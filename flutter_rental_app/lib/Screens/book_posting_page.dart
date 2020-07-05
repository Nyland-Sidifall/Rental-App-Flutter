import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
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
  List<calendar_month_widget> _calendarWidgets = [];
  List<DateTime> _bookedDates = [];
  List<DateTime> _selectedDates = [];

  void _buildCalendarWidgets(){

    for(int i = 0; i < 12; i++){
      _calendarWidgets.add(calendar_month_widget(monthIndex: i, bookedDates: _bookedDates, selectDate: _selectDate, getSelectedDates: _getSelectedDates,));
    }
    setState(() {
    });
  }

  List<DateTime> _getSelectedDates(){
    return this._selectedDates;
  }

  void _selectDate(DateTime date){
    if(this._selectedDates.contains(date)){
      this._selectedDates.remove(date);
    }else{
      this._selectedDates.add(date);
    }
    this._selectedDates.sort();
    setState(() {

    });
    print(this._selectedDates);
  }

  void _loadBookedDates(){

    this._posting.getAllBookingsFromFirestore().whenComplete((){
      this._bookedDates = this._posting.getAllBookedDates();
      this._buildCalendarWidgets();
    });
  }

  void _makeBooking(){
    if(this._selectedDates.isEmpty){return;}
    this._posting.makeNewBooking(this._selectedDates).whenComplete((){
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
   this._posting = widget.posting;
   this._loadBookedDates();
    super.initState();
  }

  void _signUp() {
    Navigator.pushNamed(context, book_posting_page.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Book ${this._posting.name}'),
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
              child: (_calendarWidgets.isEmpty) ? Container() : PageView.builder(
                itemCount: _calendarWidgets.length,
                itemBuilder: (context, index) {
                  return _calendarWidgets[index];
                },
              ),
            ),
            MaterialButton(
              onPressed: _makeBooking,
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
