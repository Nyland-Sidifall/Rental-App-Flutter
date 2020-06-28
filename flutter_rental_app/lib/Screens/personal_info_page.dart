import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class personal_info_page extends StatefulWidget {

  static final String routeName = '/personalInfoPageRoute';

  personal_info_page({Key key}) : super(key: key);

  @override
  _personal_info_page_state createState() => _personal_info_page_state();
}


class _personal_info_page_state extends State<personal_info_page> {

  TextEditingController _firstNameController;
  TextEditingController _emailController;
  TextEditingController _lastNameController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _bioController;


  void _saveInfo(){
    Navigator.pushNamed(context, guest_home_page.routeName);
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
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:40.0, bottom:40.0,),
                  child: MaterialButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width/4.8,
                      child: CircleAvatar(
                        backgroundImage: AppConstants.currentUser.displayImage,
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
