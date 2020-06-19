import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/form_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class view_posting_page extends StatefulWidget {
  static final String routeName = '/signupPageRoute';

  view_posting_page({Key key}) : super(key: key);

  @override
  _view_posting_page_state createState() => _view_posting_page_state();
}

class _view_posting_page_state extends State<view_posting_page> {
  void _signUp() {
    Navigator.pushNamed(context, guest_home_page.routeName);
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
                          /*Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Text(
                              'Apartment',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.redAccent,
                            onPressed: () {},
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
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 12.5,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                                radius: MediaQuery.of(context).size.width / 13,
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
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      posting_info_tile(
                        icon: Icon(Icons.home),
                        category: 'Apartment',
                        categoryInfo: '2 guests',
                      ),
                    ],
                  ),
                  Text(""),
                  Text('Amenitites'),
                  //GridView.count(crossAxisCount: null),
                  Text('Location'),
                  Container(),
                  Text('Reviews'),
                  review_form(),
                  //ListView.builder(itemBuilder: null),
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
  final Icon icon;
  final String category;
  final String categoryInfo;

  posting_info_tile({Key key, this.icon, this.category, this.categoryInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
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
