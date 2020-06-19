import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Screens/book_posting_page.dart';
import 'package:flutterrentalapp/Screens/view_profile_page.dart';
import 'package:flutterrentalapp/Views/form_widgets.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class view_posting_page extends StatefulWidget {
  static final String routeName = '/viewPostingRoute';

  view_posting_page({Key key}) : super(key: key);

  @override
  _view_posting_page_state createState() => _view_posting_page_state();
}

class _view_posting_page_state extends State<view_posting_page> {
  List<String> _amenities = [
    'Hair Dryer',
    'Dishwasher',
    'Iron',
    'Wifi',
    'Garage',
  ];

  LatLng _centerLatLong = LatLng(49.2827, -123.1207);
  Completer<GoogleMapController> _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Posting Information'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 2,
              child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image(
                      image: AssetImage('assets/images/apartment.jpg'),
                      fit: BoxFit.fill,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.75,
                            child: AutoSizeText(
                              'Awesome Apartment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxFontSize: 35.0,
                              minFontSize: 25.0,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context,
                                  book_posting_page.routeName,
                              );
                            },
                            child: Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            '\$120 / night',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.75,
                          child: AutoSizeText(
                            'A great place to bring to just chill. Bring your Kids, Bring your wife, bring your dogs. It doesn\'t matter. It\'s an all round romp',
                            style: TextStyle(),
                            minFontSize: 15.0,
                            maxFontSize: 20.0,
                            maxLines: 5,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  view_profile_page.routeName,
                                );
                              },
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 12.5,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                  radius: MediaQuery.of(context).size.width / 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Nyland Sidifall',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        posting_info_tile(
                          iconData: Icons.home,
                          category: 'Apartment',
                          categoryInfo: '2 guests',
                        ),
                        posting_info_tile(
                          iconData: Icons.hotel,
                          category: '1 Bedroom',
                          categoryInfo: '1 King',
                        ),
                        posting_info_tile(
                          iconData: Icons.wc,
                          category: '1 Bathroom',
                          categoryInfo: '1 Full',
                        ),
                      ],
                    ),
                  ),
                  Text(""),
                  Text(
                    'Amenitites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 1,
                      children: List.generate(
                        _amenities.length,
                        (index) {
                          return Text(
                            _amenities[index],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25),
                    child: Text(
                      '1111 FakeAddy, Fake City, Country.jpg',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: GoogleMap(
                        onMapCreated: (controller){
                          _completer.complete(controller);
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: _centerLatLong,
                            zoom: 14,
                        ),
                        markers: <Marker>{
                          Marker(
                            markerId: MarkerId('Home Location'),
                            position: _centerLatLong,
                            icon: BitmapDescriptor.defaultMarker,
                          ),
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: review_form(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top:10.0,bottom:10.0),
                          child: ReviewListTile(),
                        );
                      },
                    ),
                  ),                  //ListView.builder(itemBuilder: null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class posting_info_tile extends StatelessWidget {
  final IconData iconData;
  final String category;
  final String categoryInfo;

  posting_info_tile({Key key, this.iconData, this.category, this.categoryInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this.iconData,
        size: 30,
      ),
      title: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Text(
        categoryInfo,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
