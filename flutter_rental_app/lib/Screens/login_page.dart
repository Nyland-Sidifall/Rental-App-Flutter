import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/data.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Screens/signup_page.dart';


class login_page extends StatefulWidget {

  static final String routeName = '/loginPageRoute';

  login_page({Key key}) : super(key: key);

  @override
  _login_page_state createState() => _login_page_state();
}

class _login_page_state extends State<login_page> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  void _signUp(){
    Navigator.pushNamed(context, signup_page.routeName);
  }

  void _logIn(){
    if(_formKey.currentState.validate()){
      String email = _emailController.text;
      String password = _passwordController.text;

      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      ).then((firebaseUser) {
       String userID = firebaseUser.user.uid;
       AppConstants.currentUser = User(id: userID);
       AppConstants.currentUser.getPersonalInfoFromFirestore().whenComplete((){
         Navigator.pushNamed(context, guest_home_page.routeName);
       });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to ${AppConstants.appName}!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email"
                        ),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                        validator: (text){
                          if(!text.contains('@')){
                            return 'Please return a valid email';
                          }
                          return null;
                        },
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
                        obscureText: true,
                        validator: (text){
                          if(text.length < 6){
                            return 'Password must be at leaset 6 characters';
                          }
                          return null;
                        },
                        controller: _passwordController,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: MaterialButton(
                  onPressed: () {
                    _logIn();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height/15,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: MaterialButton(
                  onPressed: () {
                    _signUp();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height/15,
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
    );
  }
}
