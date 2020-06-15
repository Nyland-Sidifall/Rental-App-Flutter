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
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: Text(
                'Upcoming Trips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15, bottom:25),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
              ),
            ),
            Text(
              'Previous Trips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15, bottom:25),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
