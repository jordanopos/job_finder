import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'package:jobtora/src/app/main/home/pages/home_page.dart';
import 'package:jobtora/src/app/main/profile/pages/profile_page.dart';
import 'package:jobtora/src/app/main/saved/pages/saved_page.dart';
import 'package:jobtora/src/app/main/search/pages/search_page.dart';
import 'package:jobtora/src/meta/local_storage/repository/hive_repository.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';
import 'package:jobtora/src/meta/ui/widgets/svg_picture.dart';

// these ar the images for the logos and all that

List<String> companyLogos = [
  'jiji_logo.png',
  'jumia_logo.png',
  'google_logo.png',
  'apple_logo.png',
  'netflix_logo.png',
  'youtube_logo.png',
  'ura_logo.ico'
];

List<String> companyNames = [
  'Jiji Uganda',
  'Jumia Uganda',
  'Google',
  'Apple',
  'Netflix',
  'Youtube',
  'Uganda Revenue Authority'
];

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    HomePage(),
    SearchPage(),
    SavedPage(),
    Scaffold(),
    ProfilePage()
  ];

  Color? getColor(int index) {
    return index == pageIndex ? AppColors.mainBlue : AppColors.darkBlue;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pageList[pageIndex],
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          // selectedItemColor: Colors.blueAccent,
          // unselectedItemColor: Colors.grey[800],
          // selectedFontSize: 12.5,
          // unselectedFontSize: 12.5,
          // type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: (int newValue) {
            setState(() {
              pageIndex = newValue;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SvgImage('assets/icons/fi-br-home.svg',
                    height: 18, color: getColor(0)),
              ),
              //    label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SvgImage('assets/icons/fi-br-search.svg',
                    height: 18, color: getColor(1)),
              ),
              //     label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SvgImage('assets/icons/fi-br-bookmark.svg',
                    height: 18, color: getColor(2)),
              ),
              //       label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SvgImage('assets/icons/fi-br-bell.svg',
                    height: 18, color: getColor(3)),
              ),
              //     label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SvgImage('assets/icons/fi-br-user.svg',
                    height: 18, color: getColor(4)),
              ),
              //     label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
