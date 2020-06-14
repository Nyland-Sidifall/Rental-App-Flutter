import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class trips_page extends StatefulWidget {

  trips_page({Key key}) : super(key: key);

  @override
  _trips_page_state createState() => _trips_page_state();
}

class _trips_page_state extends State<trips_page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Trips Page'),
    );
  }
}
