import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';

class calendar_month_widget extends StatefulWidget {
  final int monthIndex;
  final List<DateTime> bookedDates;
  final Function selectDate;
  final Function getSelectedDates;

  calendar_month_widget({this.getSelectedDates, this.selectDate, Key key, this.monthIndex, this.bookedDates}) : super(key: key);

  @override
  _calendar_month_state createState() => _calendar_month_state();
}

class _calendar_month_state extends State<calendar_month_widget> {
  List<DateTime> _selectedDates = [];
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


  void _selectDate(DateTime date){
    if(this._selectedDates.contains(date)){
      this._selectedDates.remove(date);
    }else{
      this._selectedDates.add(date);
    }
    widget.selectDate(date);
    setState(() {
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
    this._selectedDates.sort();
    _selectedDates.addAll(widget.getSelectedDates());
    _setUpMonthTiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: AutoSizeText(
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
            if(monthTile.dateTime == null){
              return MaterialButton(
                onPressed: null,
                child: AutoSizeText(""),
              );
            }
            if (widget.bookedDates.contains((monthTile.dateTime))){
              return MaterialButton(
                  onPressed: null,
                  child: monthTile,
                color: Colors.yellow,
                disabledColor: Colors.yellow,
              );
            }
            return MaterialButton(
                onPressed: () {
                  _selectDate(monthTile.dateTime);
                },
                child: monthTile,
              color: (this._selectedDates.contains(monthTile.dateTime)) ? Colors.blue : Colors.white,
            );
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
    return AutoSizeText(
        this.dateTime == null ? "" : this.dateTime.day.toString(),
            style: TextStyle(
              fontSize: 5,
            ),
    );
  }
}
