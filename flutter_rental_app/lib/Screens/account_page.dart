import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
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

  void _logOut(){
    Navigator.pushNamed(context, login_page.routeName);
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
                      Navigator.pushNamed(context, view_profile_page.routeName);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.width/9.5,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      radius: MediaQuery.of(context).size.width/10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        'Nyland Sidifall',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      AutoSizeText(
                        'fakeemail@gmail.com',
                        style: TextStyle(
                          fontSize: 20,
                        ),
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
                height: MediaQuery.of(context).size.height/9.0,
                onPressed: () {
                  Navigator.pushNamed(context, personal_info_page.routeName);
                },
                child: AccountPageListTile(text: 'Personal Information', iconData: Icons.person),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height/9.0,
                onPressed: () {},
                child: AccountPageListTile(text: 'Become a Host', iconData: Icons.hotel),
              ),
              MaterialButton(
                height: MediaQuery.of(context).size.height/9.0,
                onPressed: () {
                  _logOut();
                },
                child: AccountPageListTile(text: 'Log Out', iconData:  null),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

class AccountPageListTile extends StatelessWidget{

  AccountPageListTile({Key key, this.text, this.iconData}) : super(key:key);

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
