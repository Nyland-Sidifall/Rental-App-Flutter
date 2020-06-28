import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Views/grid_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';
import 'package:flutterrentalapp/Screens/view_posting_page.dart';



class trips_page extends StatefulWidget {

  trips_page({Key key}) : super(key: key);

  @override
  _trips_page_state createState() => _trips_page_state();
}

class _trips_page_state extends State<trips_page> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: Text(
                'Upcoming Trips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15, bottom:25),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: AppConstants.currentUser.getUpcomingTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    Booking currentBooking = AppConstants.currentUser.getUpcomingTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right:15.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: InkResponse(
                            enableFeedback: true,
                            child: trip_grid_tile(booking: currentBooking,),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => view_posting_page(posting: currentBooking.posting),
                                ),
                              );
                            },
                          ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Text(
              'Previous Trips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15, bottom:25),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: AppConstants.currentUser.getPreviousTrips().length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    Booking currentBooking = AppConstants.currentUser.getPreviousTrips()[index];
                    return Padding(
                      padding: const EdgeInsets.only(right:15.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: InkResponse(
                            enableFeedback: true,
                            child: trip_grid_tile(booking: currentBooking,),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => view_posting_page(posting: currentBooking.posting),
                                ),
                              );
                            },
                          ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
