import 'dart:io';

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
  String password;

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

  Future<void> addUserToFirestore() async {
    Map<String, dynamic> data = {
      "bio" : this.bio,
      "city" : this.city,
      "country": this.country,
      "email": this.email,
      "firstName": this.firstName,
      "isHost": false,
      "lastName": this.lastName,
      "myPostingIDs": [],
      "savedPostingIDs": []
    };
    await Firestore.instance.document('users/${this.id}').setData(data);
  }

  Future<void> updateUserInFirestore() async {
    Map<String, dynamic> data = {
      "bio" : this.bio,
      "city" : this.city,
      "country": this.country,
      "firstName": this.firstName,
      "lastName": this.lastName,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
  }

  Future<void> addImageToFirestore(File imageFile) async {
    StorageReference reference = FirebaseStorage.instance.ref().child('userImages/${this.id}/profile_pic.jpg');
    await reference.putFile(imageFile).onComplete;
    this.displayImage = MemoryImage(imageFile.readAsBytesSync());
  }

  void changeCurrentlyHosting(bool isHosting){
    this.isCurrentlyHosting = isHosting;
  }

  Future<void> becomeHost() async {
    this.isHost = true;
    Map<String,dynamic> data = {
      'isHost' : true,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
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

  Future<void> addPostingToMyPostings(Posting posting) async {
    this.myPostings.add(posting);
    List<String> myPostingIDs = [];
    this.myPostings.forEach((posting) {
      myPostingIDs.add(posting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'myPostingIDs': myPostingIDs,
    });
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

  Future<void> addBookingToFirestore(Booking booking) async {
    Map<String, dynamic> data = {
      'dates': booking.dates,
      'postingID': booking.posting.id,
    };
    await Firestore.instance.document('users/${this.id}/bookings/${booking.id}').setData(data);
    this.bookings.add(booking);
    await addBookingConversation(booking);
  }

  Future<void> addBookingConversation(Booking booking) async {
    Conversation conversation = Conversation();
    conversation.addConversationToFirestore(booking.posting.host);
    String text = "Hi my name is ${AppConstants.currentUser.firstName} and I have "
        "just booked ${booking.posting.name} from ${booking.dates.first} to "
        "${booking.dates.last} if you have any questions contact me. Enjoy your "
        "stay!";
    await conversation.addMessageToFirestore(text);
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

  Future<void> addSavedPosting(Posting posting) async {
    for(var savedPosting in this.savedPostings){
      if(savedPosting.id == posting.id){
        return;
      }
    }
    this.savedPostings.add(posting);
    List<String> savedPostingIDs = [];
    this.savedPostings.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'savedPostingIDs':savedPostingIDs,
    });
  }

  Future<void> removeSavedPosting(Posting posting) async {
    for(int i = 0; i < this.savedPostings.length; i++){
      if(this.savedPostings[i].id == posting.id){
        this.savedPostings.removeAt(i);
        break;
      }
    }
    List<String> savedPostingIDs = [];
    this.savedPostings.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id);
    });
    await Firestore.instance.document('users/${this.id}').updateData({
      'savedPostingIDs':savedPostingIDs,
    });
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

  Future<void> postNewReview(String text, double rating) async {
    Map<String,dynamic> data = {
      'dateTime': DateTime.now(),
      'name': AppConstants.currentUser.getFullName(),
      'rating': rating,
      'text': text,
      'userID': AppConstants.currentUser.id,
    };
    await Firestore.instance.collection('users/${this.id}/reviews').add(data);
  }

}