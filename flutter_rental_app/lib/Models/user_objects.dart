import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Models/review_objects.dart';

class Contact{

  String id;
  String firstName;
  String lastName;
  String fullName;
  MemoryImage displayImage;

  Contact({this.id = "",this.firstName = "", this.lastName="", this.displayImage});

  String getFullName(){
    return this.fullName = this.firstName +" "+this.lastName;
  }

  Future<void> getContactInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
  }

  Future<MemoryImage> getImageFromStorage() async {
    if(displayImage != null){return displayImage;}
    final String imagePath = "userImages/${this.id}/profile_pic.jpg";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
    this.displayImage = MemoryImage(imageData);
    return this.displayImage;
  }


  User createUserFromContact(){
    return User(
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      displayImage: this.displayImage,
    );
  }
}


class User extends Contact{

  DocumentSnapshot snapshot;
  String email;
  String bio;
  String city;
  String country;
  bool isHost;
  bool isCurrentlyHosting;

  List<Booking> bookings;
  List<Review> reviews;
  List<Conversation> conversations;
  List<Posting> savedPostings;
  List<Posting> myPostings;

  User({String id = "", String firstName = "", String lastName="", MemoryImage displayImage,
  this.email = "", this.bio = "", this.city = "", this.country=""
  }):super(id: id, firstName: firstName, lastName: lastName, displayImage: displayImage){
    this.isHost = false;
    this.isCurrentlyHosting = false;
    this.bookings=[];
    this.reviews=[];
    this.conversations = [];
    this.savedPostings = [];
    this.myPostings = [];
  }

  Future<void> getUserInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(this.id).get();
    this.snapshot = snapshot;
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
    this.email = snapshot['email'] ?? "";
    this.bio = snapshot['bio'] ?? "";
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.isHost = snapshot['isHost'] ?? false;
  }

  Future<void> getPersonalInfoFromFirestore() async {
    await getUserInfoFromFirestore();
    await getImageFromStorage();
    await getMyPostingsFromFirestore();
    await getSavedPostingsFromFirestore();
    await getAllBookingsFromFirestore();
  }

  Future<void> getMyPostingsFromFirestore() async {
    List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']) ?? [];
    for(String postingID in myPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getAllBookingsFromFirestore();
      await newPosting.getAllImagesFromStorage();
      this.myPostings.add(newPosting);
    }
  }

  Future<void> getSavedPostingsFromFirestore() async {
    List<String> savedPostingIDs = List<String>.from(snapshot['savedPostingIDs']) ?? [];
    for(String postingID in savedPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getFirstImageFromStorage();
      this.savedPostings.add(newPosting);
    }
  }


  void changeCurrentlyHosting(bool isHosting){
    this.isCurrentlyHosting = isHosting;
  }

  void becomeHost(){
    this.isHost = true;
    this.changeCurrentlyHosting(true);
  }

  Contact createContactFromUser(){
    return Contact(
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      displayImage: this.displayImage,
    );
  }

  Future<void> getAllBookingsFromFirestore() async {
    this.bookings = [];
    QuerySnapshot snapshots = await Firestore.instance.collection('users/${this.id}/bookings').getDocuments();
    for(var snapshot in snapshots.documents){
      Booking newBooking = Booking();
      await newBooking.getBookingInfoFromFirestoreFromUser(this.createContactFromUser(), snapshot);
      this.bookings.add(newBooking);
    }
  }

  void makeNewBooking(Booking booking){
    this.bookings.add(booking);
  }

  List<DateTime> getAllBookedDates(){
    List<DateTime> allBookedDates = [];
   this.myPostings.forEach((posting) {
     posting.bookings.forEach((booking) {
       allBookedDates.addAll(booking.dates);
     });
   });
   return allBookedDates;
  }

  void addSavedPosting(Posting posting){
    this.savedPostings.add(posting);
  }

  void removeSavedPosting(Posting posting){
    for(int i = 0; i < this.savedPostings.length; i++){
      if(this.savedPostings[i].name == posting.name){
        this.savedPostings.removeAt(i);
      }
    }
  }

  List<Booking> getPreviousTrips() {
    List<Booking> previousTrips = [];
    this.bookings.forEach((booking) {
      if(booking.dates.last.compareTo(DateTime.now()) <= 0){
        previousTrips.add(booking);
      }
    });
    return previousTrips;
  }

  List<Booking> getUpcomingTrips() {
    List<Booking> upcomingTrips = [];
    this.bookings.forEach((booking) {
      if(booking.dates.last.compareTo(DateTime.now()) > 0){
        upcomingTrips.add(booking);
      }
    });
    return upcomingTrips;
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