//class of custom widgets

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/view_posting_page.dart';
import 'package:flutterrentalapp/Screens/view_profile_page.dart';

class ReviewListTile extends StatefulWidget {
  ReviewListTile({Key key}) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: MediaQuery.of(context).size.width / 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AutoSizeText(
                'FinstaName',
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
              rating: 4.5,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15),
          child: AutoSizeText('His place was GRRREAT! That\'s all folkes!'),
        ),
      ],
    );
  }
}

class conversation_list_tile extends StatefulWidget {
  conversation_list_tile({Key key}) : super(key: key);

  @override
  _conversation_list_tile_state createState() =>
      _conversation_list_tile_state();
}

class _conversation_list_tile_state extends State<conversation_list_tile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            view_profile_page.routeName,
          );
        },
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.png'),
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        'Kevin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.5,
        ),
      ),
      subtitle: Text(
        'Hey! How\'s it goin fam?!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      trailing: Text(
        'August 30th',
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
  message_list_tile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Padding(
      padding: const EdgeInsets.fromLTRB(15.0,15.0,35,15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                    context,
                    view_profile_page.routeName
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
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
                        'Hey, How\'s it going fam?! I hope you are doing well. This is'
                            ' not a real message, i\'m just trying to test my app and '
                            'making sure text wraps gooooood lmao.',
                        style: TextStyle(
                          fontSize: 20.0,

                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                        child: Text(
                            'September 1st',
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
    );*/
        Padding(
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
                        'Hey, How\'s it going fam?! I hope you are doing well. This is'
                        ' not a real message, i\'m just trying to test my app and '
                        'making sure text wraps gooooood lmao.',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'September 1st',
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
              Navigator.pushNamed(context, view_profile_page.routeName);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),
        ],
      ),
    );
  }
}

class my_posting_list_tile extends StatefulWidget {
  my_posting_list_tile({Key key}) : super(key: key);

  @override
  _my_posting_list_tile_state createState() => _my_posting_list_tile_state();
}

class _my_posting_list_tile_state extends State<my_posting_list_tile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: AutoSizeText(
            'Awesome Apartment!',
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
            image: AssetImage('assets/images/apartment.jpg'),
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
