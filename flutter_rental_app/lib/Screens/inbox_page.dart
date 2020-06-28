import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Screens/conversation_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class inbox_page extends StatefulWidget {
  inbox_page({Key key}) : super(key: key);

  @override
  _inbox_page_state createState() => _inbox_page_state();
}

class _inbox_page_state extends State<inbox_page> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        itemCount: AppConstants.currentUser.conversations.length,
        itemExtent: MediaQuery.of(context).size.height / 7,
        itemBuilder: (context, index) {
          Conversation currentConversation = AppConstants.currentUser.conversations[index];
          return InkResponse(
            child: conversation_list_tile(conversation: currentConversation,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => conversation_page(conversation: currentConversation,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
