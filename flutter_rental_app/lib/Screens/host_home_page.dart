import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Screens/account_page.dart';
import 'package:flutterrentalapp/Screens/bookings_pages.dart';
import 'package:flutterrentalapp/Screens/explore_page.dart';
import 'package:flutterrentalapp/Screens/inbox_page.dart';
import 'package:flutterrentalapp/Screens/my_postings_page.dart';
import 'package:flutterrentalapp/Screens/saved_page.dart';
import 'package:flutterrentalapp/Screens/trips_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class host_home_page extends StatefulWidget {

  static final String routeName = '/hostHomePageRoute';
  final int index;

  host_home_page({Key key, this.index}) : super(key: key);

  @override
  _host_home_page_state createState() => _host_home_page_state();
}

class _host_home_page_state extends State<host_home_page> {

  int _selectedIndex = 3;

  final List<String> _pageTitles = [
    'Bookings',
    'My Postings',
    'Inbox',
    'Profile',
  ];

  final List<Widget> _pages = [
    bookings_page(),
    my_postings_page(),
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
  void initState() {
    this._selectedIndex = widget.index ?? 3;
    super.initState();
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
          _buildNavigationItem(0, Icons.calendar_today,_pageTitles[0]),
          _buildNavigationItem(1, Icons.home,_pageTitles[1]),
          _buildNavigationItem(2, Icons.message,_pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline,_pageTitles[3]),
        ],
      ),
    );
  }
}
