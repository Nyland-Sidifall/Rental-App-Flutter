import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';
import 'package:image_picker/image_picker.dart';


class personal_info_page extends StatefulWidget {

  static final String routeName = '/personalInfoPageRoute';

  personal_info_page({Key key}) : super(key: key);

  @override
  _personal_info_page_state createState() => _personal_info_page_state();
}


class _personal_info_page_state extends State<personal_info_page> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController;
  TextEditingController _emailController;
  TextEditingController _lastNameController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _bioController;

  File _newImageFile;

  void _chooseImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      _newImageFile = imageFile;
      setState(() {});
    }
  }

  void _saveInfo(){
    if(!_formKey.currentState.validate()){return;}
    AppConstants.currentUser.firstName = _firstNameController.text;
    AppConstants.currentUser.lastName = _lastNameController.text;
    AppConstants.currentUser.city = _cityController.text;
    AppConstants.currentUser.country= _countryController.text;
    AppConstants.currentUser.bio = _bioController.text;
    AppConstants.currentUser.updateUserInFirestore().whenComplete((){
      if(_newImageFile != null){
        AppConstants.currentUser.addImageToFirestore(_newImageFile).whenComplete((){
          Navigator.pushNamed(context, guest_home_page.routeName);
        });
      }else{
        Navigator.pushNamed(context, guest_home_page.routeName);
      }
    });
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: AppConstants.currentUser.firstName);
    _lastNameController = TextEditingController(text: AppConstants.currentUser.lastName);
    _emailController = TextEditingController(text: AppConstants.currentUser.email);
    _cityController = TextEditingController(text: AppConstants.currentUser.city);
    _countryController = TextEditingController(text: AppConstants.currentUser.country);
    _bioController = TextEditingController(text: AppConstants.currentUser.bio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Personal Information'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: _saveInfo,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "First Name"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _firstNameController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a first name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Last Name"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _lastNameController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a last name";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Email"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          enabled: false,
                          controller: _emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Password"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          enabled: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "City"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _cityController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a valid city";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Country"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _countryController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a valid country";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Bio"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          maxLines: 3,
                          controller: _bioController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter a valid bio";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:40.0, bottom:40.0,),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width/4.8,
                      child: CircleAvatar(
                        backgroundImage: (_newImageFile != null) ? FileImage(_newImageFile) : AppConstants.currentUser.displayImage,
                        radius: MediaQuery.of(context).size.width/5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
