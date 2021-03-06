import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Screens/host_home_page.dart';
import 'package:flutterrentalapp/Screens/login_page.dart';
import 'package:flutterrentalapp/Screens/personal_info_page.dart';
import 'package:flutterrentalapp/Screens/view_profile_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class account_page extends StatefulWidget {
  account_page({Key key}) : super(key: key);

  @override
  _account_page_state createState() => _account_page_state();
}

class _account_page_state extends State<account_page> {
  String _hostingTitle = 'To Host Dashboard';

  void _changeHosting(){
    if(AppConstants.currentUser.isHost){
      if(AppConstants.currentUser.isCurrentlyHosting){
        AppConstants.currentUser.isCurrentlyHosting = false;
        Navigator.pushNamed(
          context,
          guest_home_page.routeName,
        );
      } else {
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          host_home_page.routeName,
        );
      }
    }else{
      AppConstants.currentUser.becomeHost().whenComplete((){
        AppConstants.currentUser.isCurrentlyHosting = true;
        Navigator.pushNamed(
          context,
          host_home_page.routeName,
        );
      });
    }



  }

  void _logOut() {
    Navigator.pushNamed(context, login_page.routeName);
  }

  @override
  void initState() {
    if(AppConstants.currentUser.isHost){
      if (AppConstants.currentUser.isCurrentlyHosting) {
        _hostingTitle = 'To Guest Dashboard';
      }else{
        _hostingTitle = 'To Host Dashboard';
      }
    }else{
      _hostingTitle = 'Become a host';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => view_profile_page(contact: AppConstants.currentUser.createContactFromUser()),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width / 9.5,
                    child: CircleAvatar(
                      backgroundImage: AppConstants.currentUser.displayImage,
                      radius: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        AppConstants.currentUser.getFullName(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,

                        ),
                      ),
                      AutoSizeText(
                        AppConstants.currentUser.email,
                        minFontSize: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  Navigator.pushNamed(context, personal_info_page.routeName);
                },
                child: AccountPageListTile(
                    text: 'Personal Information', iconData: Icons.person),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  _changeHosting();
                },
                child: AccountPageListTile(
                    text: _hostingTitle, iconData: Icons.hotel),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height / 9.0,
                onPressed: () {
                  _logOut();
                },
                child: AccountPageListTile(text: 'Log Out', iconData: null),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountPageListTile extends StatelessWidget {
  AccountPageListTile({Key key, this.text, this.iconData}) : super(key: key);

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      leading: Text(
        this.text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Icon(
        this.iconData,
        size: 35.0,
      ),
    );
  }
}
