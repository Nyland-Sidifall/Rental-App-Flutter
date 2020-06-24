import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class Review{

  Contact contact;
  String text;
  double rating;
  DateTime dateTime;

  Review();

  void createReview(Contact contact, String text, double rating, DateTime dateTime){
    this.contact = contact;
    this.text = text;
    this.rating = rating;
    this.dateTime = dateTime;

  }
}
