import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Models/user_objects.dart';

class review_form extends StatefulWidget{

  final Posting posting;
  final User user;

  review_form({this.posting, this.user, Key key}):super(key:key);

  @override
  _review_form_state createState() => _review_form_state();

}

class _review_form_state extends State<review_form>{

  TextEditingController _controller = new TextEditingController();
  double _rating = 2.5;

  void _submitReview(){
    if(widget.posting == null){
      widget.user.postNewReview(_controller.text, _rating).whenComplete((){
        _controller.text = "";
        _rating = 2.5;
        setState(() {});
      });
    }else{
      widget.posting.postNewReview(_controller.text, _rating).whenComplete((){
        _controller.text = "";
        _rating = 2.5;
        setState(() {});
      });
    }
  }

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
                    controller: _controller,
                    validator: (text){
                      if(text.isEmpty){
                        return "Please enter some text";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: StarRating(
                      rating: _rating,
                      size: 40.0,
                      starCount: 5,
                      color: AppConstants.selectedIcon,
                      borderColor: Colors.grey,
                      onRatingChanged: (rating){
                        _rating = rating;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: _submitReview,
              child: Text('Submit'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

}