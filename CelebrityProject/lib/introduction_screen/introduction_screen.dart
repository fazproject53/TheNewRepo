///import section
import 'dart:convert';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/introduction_screen/screen_four.dart';
import 'package:celepraty/introduction_screen/screen_one.dart';
import 'package:celepraty/introduction_screen/screen_three.dart';
import 'package:celepraty/introduction_screen/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Models/Methods/method.dart';


class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  ///Page Controller
  PageController pageController = PageController();
  ///Index
  int selectedIndex = 0;

  int currentIndex = 0;

  ///List of Pages
  List<Widget> pages = const [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
    ScreenFour()
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.toInt();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            children: pages,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h, right: 30.w, left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Skip
                InkWell(
                  onTap: () {
                    goTopagepush(context, Logging());
                  },
                  child: Visibility(
                    visible: currentIndex == 3 ? false : true,
                    child: text(context, "تخطي", 14, purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                ///Dots
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  onDotClicked: (index) {
                    pageController.jumpToPage(index);
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  effect: JumpingDotEffect(
                      spacing: 15.0,
                      radius: 25.0.r,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey,
                      verticalOffset: 15,
                      activeDotColor: purple),
                ),

                ///Start
                InkWell(
                    onTap: () {
                      goTopagepush(context, Logging());
                    },
                    child: Visibility(
                      visible: currentIndex == 3 ? true : false,
                      child: text(context, "بدء", 16, purple,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IntroData {
  bool? success;
  List<Data>? data;
  Message? message;

  IntroData({ this.success,this.data, this.message});

  IntroData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}
class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

class Data {
  String? title;
  String? title_en;
  String? text;
  String? text_en;
  String? image;

  Data({this.title, this.title_en, this.text, this.text_en, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    title_en = json['title_en'];
    text = json['text'];
    text_en = json['text_en'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_en'] = this.title_en;
    data['text'] = this.text;
    data['text_en'] = this.text_en;
    data['image'] = this.image;
    return data;
  }
}