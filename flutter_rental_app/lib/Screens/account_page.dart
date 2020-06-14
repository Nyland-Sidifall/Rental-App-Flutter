import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class account_page extends StatefulWidget {

  account_page({Key key}) : super(key: key);

  @override
  _account_page_state createState() => _account_page_state();
}

class _account_page_state extends State<account_page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Account Page'),
    );
  }
}
