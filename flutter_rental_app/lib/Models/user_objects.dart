import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  User({String firstName = "", String lastName="", String imagePath="",
  this.email = "", this.bio = "", this.city = "", this.country=""
  }):super(firstName: firstName, lastName: lastName, imagePath: imagePath){
    this.isHost = false;
    this.isCurrentlyHosting = false;
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

}