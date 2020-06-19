import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';

class calendar_month_widget extends StatefulWidget{

  final int monthIndex;

  calendar_month_widget({Key key, this.monthIndex}): super(key:key);

  @override
  _calendar_month_state createState() => _calendar_month_state();

}

class _calendar_month_state extends State<calendar_month_widget> {

  List<month_tile> _monthTiles =[];

  @override
  void initState() {
    _monthTiles = [];
    for(int i = 0; i<31; i++){
      _monthTiles.add(month_tile(dateTime: DateTime.now(),));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('August'),
        GridView.builder(
          itemCount: 31,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1/1,
            ),
            itemBuilder: (context,index){
              month_tile monthTile = _monthTiles[index];
              return monthTile;
            },
        ),
      ],
    );
  }
}

class month_tile extends StatelessWidget{

  final DateTime dateTime;

  month_tile({this.dateTime, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.dateTime == null ? "" : this.dateTime.day.toString());
  }



}