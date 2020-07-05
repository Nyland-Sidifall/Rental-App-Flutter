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

  Future<void> addPostingInfoToFirestore() async {
    setImageNames();
    Map<String,dynamic> data = {
      "address" : this.address,
      "amenities": this.amenities,
      "bathrooms": this.bathrooms,
      "beds":this.beds,
      "city": this.city,
      "country": this.country,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "name": this.name,
      "price": this.price,
      "rating": 2.5,
      "type": this.type,
    };

    DocumentReference reference = await Firestore.instance.collection('postings').add(data);
    this.id = reference.documentID;
    await AppConstants.currentUser.addPostingToMyPostings(this);
  }

  Future<void> updatePostingInfoToFirestore() async {
    setImageNames();
    Map<String,dynamic> data = {
      "address" : this.address,
      "amenities": this.amenities,
      "bathrooms": this.bathrooms,
      "beds":this.beds,
      "city": this.city,
      "country": this.country,
      "hostID": AppConstants.currentUser.id,
      "imageNames": this.imageNames,
      "name": this.name,
      "price": this.price,
      "rating": this.rating,
      "type": this.type,
    };
    await Firestore.instance.document('postings/${this.id}').updateData(data);
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

  void setImageNames(){
    this.imageNames = [];
    for(int i = 0; i < this.displayImages.length; i++){
      this.imageNames.add("pic${i}.jpg");
    }
  }


  Future<void> addImagesToFirestore() async {
    for(int i = 0; i < this.displayImages.length; i++){
      StorageReference reference = FirebaseStorage.instance.ref().child('postingImages/${this.id}/${this.imageNames[i]}');
      await reference.putData(this.displayImages[i].bytes).onComplete;
    }
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

  Future<void> makeNewBooking(List<DateTime> dates) async {
    Map<String, dynamic> bookingData = {
      'dates': dates,
      'name': AppConstants.currentUser.getFullName(),
      'userID': AppConstants.currentUser.id,
    };
    DocumentReference reference = await Firestore.instance.collection('postings/${this.id}/bookings').add(bookingData);
    Booking newBooking = Booking();
    newBooking.createBooking(this,AppConstants.currentUser.createContactFromUser(),dates);
    newBooking.id = reference.documentID;

    this.bookings.add(newBooking);
    await AppConstants.currentUser.addBookingToFirestore(newBooking);
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

  Future<void> postNewReview(String text, double rating) async {
    Map<String,dynamic> data = {
      'dateTime': DateTime.now(),
      'name': AppConstants.currentUser.getFullName(),
      'rating': rating,
      'text': text,
      'userID': AppConstants.currentUser.id,
    };

    await Firestore.instance.collection('postings/${this.id}/reviews').add(data);
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