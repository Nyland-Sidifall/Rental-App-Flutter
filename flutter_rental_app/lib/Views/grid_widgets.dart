import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';

class posting_grid_tile extends StatefulWidget {

  final Posting posting;

  posting_grid_tile({this.posting, Key key}) : super(key: key);

  @override
  _posting_grid_tile_state createState() => _posting_grid_tile_state();
}

class _posting_grid_tile_state extends State<posting_grid_tile> {


  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    super.initState();
  }

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
                image: this._posting.displayImages.first,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        AutoSizeText(
          "${_posting.type} - ${_posting.city}, ${_posting.country}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
        _posting.name,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        Text(
          '\$${_posting.price} / night',
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
              rating: _posting.getCurrentRating(),
            ),
          ],
        ),
      ],
    );
  }
}

class trip_grid_tile extends StatefulWidget {

  Booking booking;

  trip_grid_tile({this.booking, Key key}) : super(key: key);

  @override
  _trip_grid_tile_state createState() => _trip_grid_tile_state();
}

class _trip_grid_tile_state extends State<trip_grid_tile> {
  Booking _booking;
  @override
  void initState() {
    this._booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _booking.posting.displayImages.first,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),

        AutoSizeText(
          _booking.posting.name,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          '${_booking.posting.city}, ${_booking.posting.country}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '\$ ${_booking.posting.price} / night',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Text(
          '${_booking.getFirstDate()} -',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${_booking.getLastDate()}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
