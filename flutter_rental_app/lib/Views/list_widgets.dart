//class of custom widgets

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';


class ReviewListTile extends StatefulWidget{

  ReviewListTile({Key key}):super (key:key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}


class _ReviewListTileState extends State<ReviewListTile>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: MediaQuery.of(context).size.width/15,

            ),
            Padding(
              padding: const EdgeInsets.only(left:15,right:15),
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
          padding: const EdgeInsets.only(top:10.0, bottom:15),
          child: AutoSizeText(
            'His place was GRRREAT! That\'s all folkes!'
          ),
        ),
      ],
    );
  }
}

class conversation_list_tile extends StatefulWidget{

  conversation_list_tile({Key key}): super (key:key);

  @override
  _conversation_list_tile_state createState() => _conversation_list_tile_state();

}

class _conversation_list_tile_state extends State<conversation_list_tile>{

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/profile.png'),
        radius: MediaQuery.of(context).size.width/13.0,
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
      contentPadding: EdgeInsets.fromLTRB(25,15,25,15),
    );
  }


}