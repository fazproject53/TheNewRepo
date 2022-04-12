///import section
import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Celebrity/notificationList.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/Exploer/Explower.dart';
import 'package:celepraty/Users/Setting/userProfile.dart';
import 'package:celepraty/Users/chat/chatListUser.dart';
import 'package:celepraty/celebrity/Activity/activity_screen.dart';
import 'package:celepraty/celebrity/celebrityHomePage.dart';
import 'package:celepraty/celebrity/chat/chatsList.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController? pageController;
  int selectedIndex = 2;
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }


  List<Widget> Famousscreens = [
    /// Explore
    Explower(),
    /// Activity page
    notificationList(),
    /// Home Screen
    celebrityHomePage(),
    /// Chats
    chatsList(),
    /// Celebrity Profile
    celebratyProfile(),
  ];
  List<Widget> userScreen = [
    /// Explore
    Explower(),
    /// Activity page
    notificationList(),
    /// Home Screen
    celebrityHomePage(),
    /// Chats
    chatsListUser(),
    /// Celebrity Profile
    userProfile(),
  ];
  final items = <Widget>[
    ///explore icon
    GradientIcon(
        exploreIcon,
        30.w,
        const LinearGradient(
          begin: Alignment(0.7, 2.0),
          end: Alignment(-0.69, -1.0),
          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
          stops: [0.0, 1.0],
        )),

    ///notification icon
    GradientIcon(
        notificationIcon,
        30.w,
        const LinearGradient(
          begin: Alignment(0.7, 2.0),
          end: Alignment(-0.69, -1.0),
          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
          stops: [0.0, 1.0],
        )),

    ///home icon
    GradientIcon(
        homeIcon,
        30.w,
        const LinearGradient(
          begin: Alignment(0.7, 2.0),
          end: Alignment(-0.69, -1.0),
          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
          stops: [0.0, 1.0],
        )),

    ///chat icon
    GradientIcon(
        chatIcon,
        30.w,
        const LinearGradient(
          begin: Alignment(0.7, 2.0),
          end: Alignment(-0.69, -1.0),
          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
          stops: [0.0, 1.0],
        )),

    ///account icon
    GradientIcon(
        nameIcon,
        30.w,
        const LinearGradient(
          begin: Alignment(0.7, 2.0),
          end: Alignment(-0.69, -1.0),
          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
          stops: [0.0, 1.0],
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: currentuser == "famous" ? Famousscreens : userScreen,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: deepwhite,
        color: white,
        index: selectedIndex,
        items: items,
        height: 50.h,
        onTap: onTap,
      ),
    );
  }

  //click methos--------------------------
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController!.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInCirc);
  }
}
