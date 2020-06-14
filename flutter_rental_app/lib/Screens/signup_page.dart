import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class signup_page extends StatefulWidget {

  static final String routeName = '/signupPageRoute';

  signup_page({Key key}) : super(key: key);

  @override
  _signup_page_state createState() => _signup_page_state();
}


class _signup_page_state extends State<signup_page> {

  void _signUp(){
    Navigator.pushNamed(context, guest_home_page.routeName);
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
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
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
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "First Name"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
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
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:40.0, bottom:40.0,),
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
      ),
    );
  }
}
