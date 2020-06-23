import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class Posting {
  String name;
  String type;
  double price;
  String description;
  String address;
  String city;
  String country;
  double rating;

  Contact host;

  List<String> imagePaths;
  List<AssetImage> displayImages;
  List<String> amenitites;

  Map<String, int> beds;
  Map<String, int> bathrooms;

  Posting({this.name="", this.type="",this.price=0,this.description="",
    this.address="",this.city="",this.country="",this.host}) {
    this.imagePaths = [];
    this.displayImages = [];
    this.amenitites = [];
    this.beds = {};
    this.bathrooms = {};
    this.rating = 0;
  }

  int getNumGuests(){
    int numGuests = 0;
    numGuests += this.beds['small'];
    numGuests += this.beds['medium']*2;
    numGuests += this.beds['large']*2;
    return numGuests;
  }

  void setImages(List<String> imagePaths){
    this.imagePaths = imagePaths;
    imagePaths.forEach((imagePath) {
      this.displayImages.add(AssetImage(imagePath));
    });
  }

  String getAmenititesString(){
    if(this.amenitites.isEmpty){return "";}
    String amenitiesString = this.amenitites.toString();
    return amenitiesString.substring(1,amenitiesString.length-1);
  }
}