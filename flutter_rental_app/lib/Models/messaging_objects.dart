import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class Conversation{
  String id;
  Contact otherContact;
  List<Message> messages;
  Message lastMessage;

  Conversation();

  void createConversation(Contact otherContact, List<Message> messages){
    this.otherContact = otherContact;
    this.messages = messages;
    if(messages.isNotEmpty){
      this.lastMessage = messages.last;
    }
  }

  void getConversationInfoFromFirestore(DocumentSnapshot snapshot){
    this.id = snapshot.documentID;

    String lastMessageText = snapshot['lastMessageText'] ?? "";
    Timestamp lastMessageDateTimestamp = snapshot['lastMessageDateTime'] ?? Timestamp.now();
    DateTime lastMessageDateTime = lastMessageDateTimestamp.toDate();
    this.lastMessage = Message();
    this.lastMessage.dateTime = lastMessageDateTime;
    this.lastMessage.text = lastMessageText;

    Map<String,String> userInfo = Map<String,String>.from(snapshot['userInfo']);
    userInfo.forEach((id, name) {
      if(id != AppConstants.currentUser.id){
        this.otherContact = Contact(
            id:id,
            firstName: name.split(" ")[0],
            lastName: name.split(" ")[1],
        );
      }
    });
  }

  String getLastMessageText(){
    if(messages.isEmpty){
      return "";
    }else{
      return messages.last.text;
    }
  }

  String getLastMessageDateTime(){
    if(messages.isEmpty){
      return "";
    }else{
      return messages.last.getMessageDateTime();
    }
  }

}

class Message {
  Contact sender;
  String text;
  DateTime dateTime;

  Message();

  void createMessage(Contact sender, String text, DateTime dateTime){
    this.sender = sender;
    this.text = text;
    this.dateTime = dateTime;
  }

  void getMessageInfoFromFirestore(DocumentSnapshot snapshot){
    Timestamp lastMessageTimeStamp = snapshot['dateTime'] ?? Timestamp.now();
    this.dateTime = lastMessageTimeStamp.toDate();
    String senderID = snapshot['senderID'] ?? "";
    this.sender = Contact(id: senderID);
    this.text = snapshot['text'] ?? "";
  }

  String getMessageDateTime(){
    final DateTime now = DateTime.now();
    final int today = now.day;
    if(this.dateTime.day == today){
      return _getTIme();
    }else{
      return _getDate();
    }
  }

  _getTIme(){
    String time = dateTime.toIso8601String().substring(11,16);
    String hours = time.substring(0,2);
    int hoursInt = int.parse(hours);
    if(hoursInt>12){hoursInt -= 12;}
    hours = hoursInt.toString();
    String minutes = time.substring(2);
    return hours + minutes;

  }

  String _getDate(){
    String date = dateTime.toIso8601String().substring(5,10);
    String month = date.substring(0,2);
    int monthInt = int.parse(month);
    String monthName = AppConstants.monthDict[monthInt];
    String day = date.substring(3,5);
    return monthName+" "+day;
  }


}