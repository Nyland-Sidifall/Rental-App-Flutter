import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';

class review_form extends StatefulWidget{

  review_form({Key key}):super(key:key);

  @override
  _review_form_state createState() => _review_form_state();


}

class _review_form_state extends State<review_form>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Review Text'
                    ),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: StarRating(
                      rating: 2.5,
                      size: 40.0,
                      starCount: 5,
                      color: AppConstants.selectedIcon,
                      borderColor: Colors.grey,
                      onRatingChanged: (rating){

                      },
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Submit'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

}