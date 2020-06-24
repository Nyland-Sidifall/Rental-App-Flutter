import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class Conversation{
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
    String minutes = time.substring(2);
    return hours + ":" + minutes;

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