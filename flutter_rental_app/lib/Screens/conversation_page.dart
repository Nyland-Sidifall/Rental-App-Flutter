import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class conversation_page extends StatefulWidget {
  static final String routeName = '/conversationPageRoute';

  conversation_page({Key key}) : super(key: key);

  @override
  _conversation_page_state createState() => _conversation_page_state();
}

class _conversation_page_state extends State<conversation_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Kevin'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return message_list_tile();
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 5 / 6,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      contentPadding: EdgeInsets.all(20.0),
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
