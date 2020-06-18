import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';

class posting_grid_tile extends StatefulWidget {
  posting_grid_tile({Key key}) : super(key: key);

  @override
  _posting_grid_tile_state createState() => _posting_grid_tile_state();
}

class _posting_grid_tile_state extends State<posting_grid_tile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3 / 2
          ,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apartment.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        AutoSizeText(
          'Apartment - Vancouver, BC',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          'Awesome Apartment',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        Text(
          '\$120 / night',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Row(
          children: <Widget>[
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
      ],
    );
  }
}

class trip_grid_tile extends StatefulWidget {
  trip_grid_tile({Key key}) : super(key: key);

  @override
  _trip_grid_tile_state createState() => _trip_grid_tile_state();
}

class _trip_grid_tile_state extends State<trip_grid_tile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3 / 2
          ,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apartment.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),

        AutoSizeText(
          'Awesome Apartment',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          'Vancouver, BC',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '\$120 / night',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Text(
          'August 10th, 2019',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'August 12th, 2019',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
