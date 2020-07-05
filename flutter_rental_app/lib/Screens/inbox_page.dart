import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Screens/conversation_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';

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
      child: StreamBuilder(
        stream: Firestore.instance.collection('conversations').where(
            'userIDs', arrayContains: AppConstants.currentUser.id).snapshots(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  itemExtent: MediaQuery.of(context).size.height / 7,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snapshot = snapshots.data.documents[index];
                    Conversation currentConversation = Conversation();
                    currentConversation.getConversationInfoFromFirestore(snapshot);
                    return InkResponse(
                      child: conversation_list_tile(conversation: currentConversation,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                              (context) => conversation_page(conversation: currentConversation,),
                          ),
                        );
                      },
                    );
                  }
              );
          }
        },
      ),
    );
  }
}
