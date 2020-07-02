import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/review_objects.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class Posting {
  String id;
  String name;
  String type;
  double price;
  String description;
  String address;
  String city;
  String country;
  double rating;

  Contact host;

  List<String> imageNames;
  List<MemoryImage> displayImages;
  List<String> amenities;
  List<Booking> bookings;
  List<Review> reviews;

  Map<String, int> beds;
  Map<String, int> bathrooms;

  Posting({this.id = "", this.name="", this.type="",this.price=0,this.description="",
    this.address="",this.city="",this.country="",this.host}) {
    this.imageNames = [];
    this.displayImages = [];
    this.amenities = [];
    this.bookings = [];
    this.reviews =[];
    this.beds = {};
    this.bathrooms = {};
    this.rating = 0;
  }

  Future<void> getPostingInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('postings').document(this.id).get();
    this.getPostingInfoFromSnapshot(snapshot);
  }

  void getPostingInfoFromSnapshot(DocumentSnapshot snapshot){
    this.address = snapshot['address'] ?? "";
    this.amenities = List<String>.from(snapshot['amenities']) ?? [];
    this.bathrooms = Map<String,int>.from(snapshot['bathrooms']) ?? {};
    this.beds = Map<String,int>.from(snapshot['beds']) ?? {};
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.description = snapshot['description'] ?? "";

    String hostID = snapshot['hostID'] ?? "";
    this.host = Contact(id: hostID);

    this.imageNames = List<String>.from(snapshot['imageNames']) ?? [];
    this.name = snapshot['name'] ?? "";
    this.price = snapshot['price'].toDouble() ?? 0.0;
    this.rating = snapshot['rating'].toDouble() ?? 2.5;
    this.type = snapshot['type'] ?? "";
  }

  Future<MemoryImage> getFirstImageFromStorage() async {
    if(this.displayImages.isNotEmpty){return this.displayImages.first;}
    final String imagePath = "postingImages/${this.id}/${this.imageNames.first}";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
    this.displayImages.add(MemoryImage(imageData));
    return this.displayImages.first;
  }

  Future<List<MemoryImage>> getAllImagesFromStorage() async {
    this.displayImages = [];
    for(int i = 0; i < imageNames.length; i++){
      final String imagePath = "postingImages/${this.id}/${this.imageNames[i]}";
      final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
      this.displayImages.add(MemoryImage(imageData));
    }
    return this.displayImages;
  }

  Future<void> getHostFromFirestore() async {
    await this.host.getContactInfoFromFirestore();
    await this.host.getImageFromStorage();
  }

  int getNumGuests(){
    int numGuests = 0;
    numGuests += this.beds['small'];
    numGuests += this.beds['medium']*2;
    numGuests += this.beds['large']*2;
    return numGuests;
  }

//  void setImages(List<String> imagePaths){
//    this.imageNames = imagePaths;
//    imagePaths.forEach((imagePath) {
//      this.displayImages.add(AssetImage(imagePath));
//    });
//  }

  String getFullAddress(){
    return this.address + ", " + this.city + ", " + this.country;
  }

  String getAmenititesString(){
    if(this.amenities.isEmpty){return "";}
    String amenitiesString = this.amenities.toString();
    return amenitiesString.substring(1,amenitiesString.length-1);
  }

  String getBedroomText(){
    String text = "";
    if(this.beds["small"] != 0){
      text += this.beds["small"].toString() + " single/twin ";
    }
    if(this.beds["medium"] != 0){
      text += this.beds["medium"].toString() + " double ";
    }
    if(this.beds["large"] != 0){
      text += this.beds["large"].toString() + " queen/king ";
    }
    return text;
  }

  String getBathroomText(){
    String text = "";
    if(this.bathrooms["full"] != 0){
      text += this.bathrooms["full"].toString() + " full ";
    }
    if(this.bathrooms["half"] != 0){
      text += this.bathrooms["half"].toString() + " half ";
    }
    return text;
  }

  Future<void> getAllBookingsFromFirestore() async {
    this.bookings = [];
    QuerySnapshot snapshots = await Firestore.instance.collection('postings/${this.id}/bookings').getDocuments();
    for(var snapshot in snapshots.documents){
      Booking newBooking = Booking();
      await newBooking.getBookingInfoFromFirestoreFromPosting(this, snapshot);
      this.bookings.add(newBooking);
    }
  }

  void makeNewBooking(List<DateTime> dates){
    Booking newBooking = Booking();
    newBooking.createBooking(this,AppConstants.currentUser.createContactFromUser(),dates);
    this.bookings.add(newBooking);
  }

  List<DateTime> getAllBookedDates(){
    List<DateTime> dates = [];
    this.bookings.forEach((booking) { 
      dates.addAll(booking.dates);
    });
    return dates;
  }

  double getCurrentRating(){
    if(this.reviews.length == 0){return 4;}
    double rating = 0;
    this.reviews.forEach((review) {
      rating += review.rating;
    });
    rating /= this.reviews.length;
    return rating;
  }

  void postNewReview(String text, double rating){
    Review newReview = Review();
    newReview.createReview(AppConstants.currentUser.createContactFromUser(),
        text,
        rating,
        DateTime.now()
    );
    this.reviews.add(newReview);
  }

}

class Booking{
  String id;
  Posting posting;
  Contact contact;
  List<DateTime> dates;

  Booking();

  void createBooking(Posting posting, Contact contact, List<DateTime> dates){
    this.posting = posting;
    this.contact = contact;
    this.dates = dates;
    this.dates.sort();
  }

  Future<void> getBookingInfoFromFirestoreFromUser(Contact contact, DocumentSnapshot snapshot) async {
    this.contact = contact;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']) ?? [];
    this.dates = [];
    timestamps.forEach((timestamp) {
      this.dates.add((timestamp.toDate()));
    });
    String postingID = snapshot['postingID'] ?? "";
    this.posting = Posting(id: postingID);
    await this.posting.getPostingInfoFromFirestore();
    this.posting = Posting(id: postingID);
    await this.posting.getPostingInfoFromFirestore();
    await this.posting.getFirstImageFromStorage();
  }

  Future<void> getBookingInfoFromFirestoreFromPosting(Posting posting, DocumentSnapshot snapshot) async {
    this.posting = posting;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']) ?? [];
    this.dates = [];
    timestamps.forEach((timestamp) {
      this.dates.add((timestamp.toDate()));
    });
    String contactID = snapshot['userID'] ?? "";
    String fullName = snapshot['name'] ?? "";
    _loadContactInfo(id, fullName);
    this.contact = Contact(id: contactID);
  }

  void _loadContactInfo(String id, String fullName){
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
    this.contact = Contact(id: id, firstName: firstName, lastName: lastName);
  }

  String getFirstDate(){
    String firstDate = dates.first.toIso8601String();
    return firstDate.substring(0,10);
  }

  String getLastDate(){
    String lastDate = dates.last.toIso8601String();
    return lastDate.substring(0,10);
  }

}