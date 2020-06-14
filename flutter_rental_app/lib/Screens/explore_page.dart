import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class explore_page extends StatefulWidget {

  explore_page({Key key}) : super(key: key);

  @override
  _explore_page_state createState() => _explore_page_state();
}

class _explore_page_state extends State<explore_page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Explore Page'),
    );
  }
}
