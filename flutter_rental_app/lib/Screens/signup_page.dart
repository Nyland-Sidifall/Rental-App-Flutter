import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';
import 'package:image_picker/image_picker.dart';

class signup_page extends StatefulWidget {
  static final String routeName = '/signupPageRoute';

  signup_page({Key key}) : super(key: key);

  @override
  _signup_page_state createState() => _signup_page_state();
}

class _signup_page_state extends State<signup_page> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  File _imageFile;

  void _chooseImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      _imageFile = imageFile;
      setState(() {});
    }
  }

  void _signUp() {
    if (!_formKey.currentState.validate() || this._imageFile == null) {
      return;
    }

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: AppConstants.currentUser.email,
      password: AppConstants.currentUser.password,
    ).then((firebaseUser) {
      String userID = firebaseUser.user.uid;
      AppConstants.currentUser.id = userID;
      AppConstants.currentUser.firstName = _firstNameController.text;
      AppConstants.currentUser.lastName = _lastNameController.text;
      AppConstants.currentUser.city = _cityController.text;
      AppConstants.currentUser.country = _countryController.text;
      AppConstants.currentUser.bio = _bioController.text;
      AppConstants.currentUser.addUserToFirestore().whenComplete(() {
        AppConstants.currentUser.addImageToFirestore(_imageFile).whenComplete(() {
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: AppConstants.currentUser.email,
            password: AppConstants.currentUser.password,
          ).whenComplete(() {
            Navigator.pushNamed(context, guest_home_page.routeName);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Sign Up Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Tell us about you",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "First Name"),
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
                          decoration: InputDecoration(labelText: "Last Name"),
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
                          decoration: InputDecoration(labelText: "City"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _cityController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter valid city";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Country"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _countryController,
                          validator: (text) {
                            if (text.isEmpty) {
                              return "Please enter valid country";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Bio"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          maxLines: 3,
                          controller: _bioController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:40.0,),
                  child: MaterialButton(
                    onPressed: _chooseImage,
                    child: (_imageFile == null) ? Icon(Icons.add): CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width/4.8,
                      child: CircleAvatar(
                        backgroundImage: FileImage(_imageFile),
                        radius: MediaQuery.of(context).size.width/5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 40.0,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      _signUp();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
