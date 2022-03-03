import 'dart:math';

import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/celebrity/orders/advArea.dart';
import 'package:celepraty/celebrity/orders/gifttingForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/celebrity/orders/advForm.dart';
import 'package:card_swiper/card_swiper.dart';

class celebrityHomePage extends StatefulWidget {
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

int currentIndex = 0;

class _celebrityHomePageState extends State<celebrityHomePage> {
  List textList = [
    "1الفنان ابيوسف عندنا",
    "2 الفنان ابيوسف عندنا",
    "3 الفنان ابيوسف عندنا"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: purple),
          home: Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: 360.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
//slider image---------------------------------------------------------
                        imageSlider(),
//text---------------------------------------------------------
                        Container(
//margin: EdgeInsets.only(bottom:25),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [Colors.black26, Colors.transparent],
                          )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40.0.h, horizontal: 15.w),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: text(context,
                                    "${textList[currentIndex]}", 36, white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
//icone lang logo--------------------------------------------------------------
                        heroLogo()
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
//3 buttoms-----------------------------------------------
                SizedBox(height: 61.h, width: 354.w,
                child: drowButtom()),
                SizedBox(
                  height: 40.h,
                ),
//كوميديا----------------------------------------------------------
                SizedBox(
                    width:double.infinity,
                    height: 196.h,
                    child: Padding(
                      padding:EdgeInsets.all(8.0.h),
                      child: catogary("", "", ""),
                    )),
              ],
            ),
          )),
        ),
      ),
    );
  }

//------------------------------Slider image-------------------------------------------
  Widget imageSlider() {
    return Swiper(
      itemBuilder: (context, index) {
        final image = sliderImage[index];
        return Image.asset(
          image,
          fit: BoxFit.fill,
        );
      },
      onIndexChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: true,
      axisDirection: AxisDirection.left,
      itemCount: sliderImage.length,
      pagination: const SwiperPagination(),
      control: SwiperControl(
          color: grey, padding: EdgeInsets.only(left: 20.w, right: 5.w)),
    );
  }

//+ icon + logo ------------------------------------------------------------
  Widget heroLogo() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: InkWell(
            onTap: () {},
            child: SizedBox(
                height: 60.h,
                width: 60.w,
                child: GradientIcon(Icons.add, 40, gradient()))),
      ),
      Spacer(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SizedBox(
            height: 60.h,
            width: 60.w,
            child: const Image(image: AssetImage("assets/image/log.png"))),
      ),
    ]);
  }

//اكسبلور صور بيكسل--------------------------------------------------------------
  Widget drowButtom() {
    return Row(
      children: [
        showButton("صور", "assets/image/cam.jpeg"),
        SizedBox(
          width: 10.w,
        ),
        showButton("اكسبلور", "assets/image/search.jpeg"),
        SizedBox(
          width: 10.w,
        ),
        showButton("بيكسل 1 مليون", "assets/image/star.jpeg"),
      ],
    );
  }

  Widget showButton(String utext, String image) {
    return Expanded(
        child: gradientContainerNoborder(
            105,
            Stack(
              children: [
                //  Align(
                //    alignment: Alignment.topLeft,
                //    child: Image(image: AssetImage(image)),
                //  ),
                Align(
                    alignment: Alignment.center,
                    child: text(context, utext, 14, white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            reids: 20));
  }
//-catogary-------------------------------------------------------------------
  Widget catogary(String catoName, String famusName, String famusImage) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        
          itemCount: 7,
          itemBuilder: (context, int itemPosition) {
            return SizedBox(
              width: 160.w,
              height: 196.h,
              child: Card(
                color: Colors.white10,
                child: Column(children: [
                  Container(decoration: decoration(),)
                ],),
              ),
            );
          }),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      image:DecorationImage( Image(image: AssetImage())),
    );
  }
  //-------------------------------------------------------------
}
