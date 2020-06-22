import 'package:flutter/material.dart';
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
                    return calendar_month_widget(monthIndex: index);
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
                    onPressed: () {},
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
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: InkResponse(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: my_posting_list_tile()),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
