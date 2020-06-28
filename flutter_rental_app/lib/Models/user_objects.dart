import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Models/review_objects.dart';

class Contact{
  String firstName;
  String lastName;
  String fullName;
  String imagePath;
  AssetImage displayImage;

  Contact({this.firstName = "", this.lastName="", this.imagePath=""}){
    this.displayImage = AssetImage(this.imagePath);
  }

  String getFullName(){
    return this.fullName = this.firstName +" "+this.lastName;
  }

  User createUserFromContact(){
    return User(
      firstName: this.firstName,
      lastName: this.lastName,
      imagePath: this.imagePath,
    );
  }

}


class User extends Contact{
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

  User({String firstName = "", String lastName="", String imagePath="",
  this.email = "", this.bio = "", this.city = "", this.country=""
  }):super(firstName: firstName, lastName: lastName, imagePath: imagePath){
    this.isHost = false;
    this.isCurrentlyHosting = false;
    this.bookings=[];
    this.reviews=[];
    this.conversations = [];
    this.savedPostings = [];
    this.myPostings = [];
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
      firstName: this.firstName,
      lastName: this.lastName,
      imagePath: this.imagePath
    );
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