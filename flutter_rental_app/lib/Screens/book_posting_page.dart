import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/calendar_widget.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class book_posting_page extends StatefulWidget {
  static final String routeName = '/bookPostingPageRoute';
  final Posting posting;

  book_posting_page({this.posting, Key key}) : super(key: key);

  @override
  _book_posting_page_state createState() => _book_posting_page_state();
}

class _book_posting_page_state extends State<book_posting_page> {

  Posting _posting;

  @override
  void initState() {
   this._posting = widget.posting;
    super.initState();
  }

  void _signUp() {
    Navigator.pushNamed(context, book_posting_page.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Book a Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sun'),
                Text('Mon'),
                Text('Tues'),
                Text('Wed'),
                Text('Thur'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: PageView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return calendar_month_widget(monthIndex: index, bookedDates: _posting.getAllBookedDates(),);
                },
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Book Now!'),
              minWidth: double.infinity,
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
