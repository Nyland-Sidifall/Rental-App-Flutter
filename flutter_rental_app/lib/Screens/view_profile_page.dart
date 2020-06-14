import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class view_profile_page extends StatefulWidget {
  static final String routeName = '/viewProfilePageRoute';

  view_profile_page({Key key}) : super(key: key);

  @override
  _view_profile_page_state createState() => _view_profile_page_state();
}

class _view_profile_page_state extends State<view_profile_page> {
  void _signUp() {
    Navigator.pushNamed(context, guest_home_page.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'View Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 50, 35, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: AutoSizeText(
                              'Hello! My name is Nyland',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          CircleAvatar(

                            backgroundColor: Colors.black,
                            radius: MediaQuery.of(context).size.width / 9.5,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                              radius: MediaQuery.of(context).size.width / 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'About Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AutoSizeText(
                  'I am a guy who likes solving mysteries with the gang across america yall!',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AutoSizeText(
                        'Lives in FakeCity, FS!',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Reviews:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom:10.0),
                      child: ReviewListTile(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
