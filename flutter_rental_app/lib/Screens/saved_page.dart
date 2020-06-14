import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class saved_page extends StatefulWidget {

  saved_page({Key key}) : super(key: key);

  @override
  _saved_page_state createState() => _saved_page_state();
}

class _saved_page_state extends State<saved_page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Saved Page'),
    );
  }
}
