import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/account_page.dart';
import 'package:flutterrentalapp/Screens/explore_page.dart';
import 'package:flutterrentalapp/Screens/inbox_page.dart';
import 'package:flutterrentalapp/Screens/saved_page.dart';
import 'package:flutterrentalapp/Screens/trips_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class guest_home_page extends StatefulWidget {

  static final String routeName = '/guestHomePageRoute';

  guest_home_page({Key key}) : super(key: key);

  @override
  _guest_home_page_state createState() => _guest_home_page_state();
}

class _guest_home_page_state extends State<guest_home_page> {

  int _selectedIndex = 0;
  final List<String> _pageTitles = [
    'Explore',
    'Saved',
    'Trips',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    explore_page(),
    saved_page(),
    trips_page(),
    inbox_page(),
    account_page(),
  ];

  BottomNavigationBarItem _buildNavigationItem(int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: AppConstants.nonselectedIcon,),
      activeIcon: Icon(iconData, color: AppConstants.selectedIcon,),
      title: Text(
        text,
        style:TextStyle(
          color: _selectedIndex == index ? AppConstants.selectedIcon : AppConstants.nonselectedIcon

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: _pageTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          _buildNavigationItem(0, Icons.search,_pageTitles[0]),
          _buildNavigationItem(1, Icons.favorite_border,_pageTitles[1]),
          _buildNavigationItem(2, Icons.hotel,_pageTitles[2]),
          _buildNavigationItem(3, Icons.message,_pageTitles[3]),
          _buildNavigationItem(4, Icons.person_outline,_pageTitles[4]),
        ],
      ),
    );
  }
}
