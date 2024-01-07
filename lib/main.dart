import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:restro/screens/homepage.dart';
import 'package:restro/screens/loading_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:restro/screens/order_screen.dart';
import 'package:restro/screens/profile_screen.dart';
import 'package:restro/screens/scan_screen.dart';
import 'package:restro/screens/search_screen.dart';

void main() {
  GeocodingPlatform.instance = GeocodingPlatform.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        LoadingScreen(),
        SearchScreen(), // Add the missing screens here
        ScanScreen(),
        OrderScreen(),
        ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.house),
          title: ("Home"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.redAccent.shade100,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: ("Search"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.redAccent.shade100,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
          title: ("Scan"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.redAccent.shade100,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.tag),
          title: ("Order"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.redAccent.shade100,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.user),
          title: ("Profile"),
          activeColorPrimary: Colors.red,
          inactiveColorPrimary: Colors.redAccent.shade100,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
