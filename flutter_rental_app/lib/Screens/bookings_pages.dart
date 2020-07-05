import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/book_posting_page.dart';
import 'package:flutterrentalapp/Views/calendar_widget.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class bookings_page extends StatefulWidget {
  static final String routeName = '/bookingsPageRoute';

  bookings_page({Key key}) : super(key: key);

  @override
  _bookings_page_state createState() => _bookings_page_state();
}

class _bookings_page_state extends State<bookings_page> {

  List<DateTime> _bookedDates = [];
  List<DateTime> _allBookedDates = [];
  Posting _selectedPosting;

  List<DateTime> _getSelectedDates(){
    return [];
  }

  void _selectDate(DateTime date){}

  void _selectAPosting(Posting posting){
    _selectedPosting = posting;
    this._bookedDates = posting.getAllBookedDates();
    setState(() {});
  }

  void _clearSelectedPosting(){
    this._bookedDates = _allBookedDates;
    this._selectedPosting = null;
    setState(() {});
  }

  @override
  void initState() {
    this._bookedDates = AppConstants.currentUser.getAllBookedDates();
    this._allBookedDates = AppConstants.currentUser.getAllBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 35),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: PageView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return calendar_month_widget(monthIndex: index, bookedDates: this._bookedDates, selectDate: _selectDate, getSelectedDates: _getSelectedDates,);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filter by Posting',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MaterialButton(
                    onPressed: _clearSelectedPosting,
                    child: Text('Reset',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Container(),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: AppConstants.currentUser.myPostings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: InkResponse(
                      onTap: () {
                        _selectAPosting(AppConstants.currentUser.myPostings[index]);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedPosting == AppConstants.currentUser.myPostings[index] ?  Colors.blue : Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: my_posting_list_tile(posting: AppConstants.currentUser.myPostings[index],)),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
