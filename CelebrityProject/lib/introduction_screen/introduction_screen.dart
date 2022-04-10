///import section

import 'dart:convert';
import 'dart:io';

import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/introduction_screen/screen_four.dart';
import 'package:celepraty/introduction_screen/screen_one.dart';
import 'package:celepraty/introduction_screen/screen_three.dart';
import 'package:celepraty/introduction_screen/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Models/Methods/method.dart';



class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  ///Page Controller
  PageController pageController = PageController(viewportFraction: 0.8);
  ///selected index
  int selectedIndex = 0;

  ///current index
  int currentIndex = 0;

  ///List of Pages
  List<Widget> pages = const [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
    ScreenFour()
  ];

  late Future<IntroData> getData;
  Future<IntroData> getIntroData() async {
    final data = await http
        .get(Uri.parse("http://mobile.celebrityads.net/api/sliders"));
    if (data.statusCode == 200) {
      return IntroData.fromJson(jsonDecode(data.body));
    } else {
      throw Exception('Failed to load activity');
    }
  }

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

    setState(() {
      getData = getIntroData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: CustomPageViewScrollPhysics(),
            controller: pageController,
            children: [
              ScreenOne(),
              ScreenTwo(),
              ScreenThree(),
              ScreenFour()
            ],

          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h, right: 30.w, left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Skip
                InkWell(
                  onTap: () {
                    goTopagepush(context, const Logging());
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
                      goTopagepush(context, const Logging());
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
///API Section
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
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? titleEn;
  String? text;
  String? textEn;
  String? image;

  Data({this.title, this.titleEn, this.text, this.textEn, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleEn = json['title_en'];
    text = json['text'];
    textEn = json['text_en'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['title_en'] = titleEn;
    data['text'] = text;
    data['text_en'] = textEn;
    data['image'] = image;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }
  @override
  SpringDescription get spring => const SpringDescription(
    mass: 100,
    stiffness: 100,
    damping: 0.1,
  );
}




