import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class inbox_page extends StatefulWidget {

  inbox_page({Key key}) : super(key: key);

  @override
  _inbox_page_state createState() => _inbox_page_state();
}

class _inbox_page_state extends State<inbox_page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Inbox Page'),
    );
  }
}