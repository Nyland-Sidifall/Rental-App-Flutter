import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';

class calendar_month_widget extends StatefulWidget {
  final int monthIndex;

  calendar_month_widget({Key key, this.monthIndex}) : super(key: key);

  @override
  _calendar_month_state createState() => _calendar_month_state();
}

class _calendar_month_state extends State<calendar_month_widget> {
  List<month_tile> _monthTiles = [];
  int _currentMonthInt;
  int _currentYearInt;

  void _setUpMonthTiles() {
    setState(() {
      _monthTiles = [];
      int daysInMonth = AppConstants.daysInMonths[_currentMonthInt];
      DateTime firstDayOfMonth = DateTime(_currentYearInt, _currentMonthInt, 1);
      int firstWeekOfMonth = firstDayOfMonth.weekday;
      if(firstWeekOfMonth != 7){
        for (int i = 0; i < firstWeekOfMonth; i++) {
          _monthTiles.add(month_tile(dateTime: null,));
        }
      }
      for (int i = 1; i <= daysInMonth; i++) {
        DateTime date = DateTime(_currentYearInt, _currentMonthInt, i);
        _monthTiles.add(month_tile(dateTime: date));
      }
    });
  }

  @override
  void initState() {
    _currentMonthInt = (DateTime.now().month + widget.monthIndex) % 12;
    if (_currentMonthInt == 0) {
      _currentMonthInt = 12;
    }

    _currentYearInt = DateTime.now().year;
    if (_currentMonthInt < DateTime.now().month) {
      _currentYearInt += 1;
    }

    _setUpMonthTiles();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
              " ${AppConstants.monthDict[_currentMonthInt]} - $_currentYearInt"),
        ),
        GridView.builder(
          itemCount: _monthTiles.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1 / 1,
          ),
          itemBuilder: (context, index) {
            month_tile monthTile = _monthTiles[index];
            return MaterialButton(onPressed: () {}, child: monthTile);
          },
        ),
      ],
    );
  }
}

class month_tile extends StatelessWidget {
  final DateTime dateTime;

  month_tile({this.dateTime, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        this.dateTime == null ? "" : this.dateTime.day.toString());
  }
}
