//class of custom widgets

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/messaging_objects.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Models/review_objects.dart';
import 'package:flutterrentalapp/Screens/view_posting_page.dart';
import 'package:flutterrentalapp/Screens/view_profile_page.dart';

class ReviewListTile extends StatefulWidget {

  final Review review;

  ReviewListTile({this.review, Key key}) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {

  Review _review;

  @override
  void initState() {
    this._review = widget.review;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            InkResponse(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => view_profile_page(contact: _review.contact),
                  ),
                );
                },
              child: CircleAvatar(
                backgroundImage: _review.contact.displayImage,
                radius: MediaQuery.of(context).size.width / 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AutoSizeText(
                _review.contact.getFullName(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            StarRating(
              size: 20.0,
              starCount: 5,
              color: AppConstants.selectedIcon,
              borderColor: Colors.grey,
              onRatingChanged: null,
              rating: _review.rating,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15),
          child: AutoSizeText(_review.text),
        ),
      ],
    );
  }
}

class conversation_list_tile extends StatefulWidget {
  final Conversation conversation;
  conversation_list_tile({this.conversation, Key key}) : super(key: key);

  @override
  _conversation_list_tile_state createState() =>
      _conversation_list_tile_state();
}

class _conversation_list_tile_state extends State<conversation_list_tile> {

  Conversation _conversation;

  @override
  void initState() {
    this._conversation = widget.conversation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => view_profile_page(contact: _conversation.otherContact),
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: _conversation.otherContact.displayImage,
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        _conversation.otherContact.getFullName(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.5,
        ),
      ),
      subtitle: AutoSizeText(
        _conversation.getLastMessageText(),
        minFontSize: 20,
      ),
      trailing: Text(
        _conversation.getLastMessageDateTime(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 15),
    );
  }
}

class message_list_tile extends StatelessWidget {

  final Message message;

  message_list_tile({this.message, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(message.sender.firstName == AppConstants.currentUser.firstName){
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 35.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          message.getMessageDateTime(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => view_profile_page(contact: AppConstants.currentUser.createContactFromUser()),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: AppConstants.currentUser.displayImage,
                radius: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ],
        ),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0,15.0,35,15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => view_profile_page(contact: message.sender),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: message.sender.displayImage,
                radius: MediaQuery.of(context).size.width / 20,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontSize: 20.0,

                          ),
                          textWidthBasis: TextWidthBasis.parent,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          message.getMessageDateTime(),
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class my_posting_list_tile extends StatefulWidget {
  final Posting posting;
  my_posting_list_tile({this.posting, Key key}) : super(key: key);

  @override
  _my_posting_list_tile_state createState() => _my_posting_list_tile_state();
}

class _my_posting_list_tile_state extends State<my_posting_list_tile> {
  Posting _posting;
  @override
  void initState() {
    this._posting = widget.posting;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: AutoSizeText(
            _posting.name,
            maxLines: 2,
            minFontSize: 15.0,
            maxFontSize: 20.0,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: AspectRatio(
          aspectRatio: 3 / 2,
          child: Image(
            image: _posting.displayImages.first,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class create_posting_list_tile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add),
          Text(
            'Create a posting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
