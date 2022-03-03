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
                            colors: [Colors.black, Colors.black12],
                          )),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 40.0.h,horizontal:15.w),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: text(context, "${textList[currentIndex]}",
                                    36, white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
//icone lang logo--------------------------------------------------------------
                        heroLogo()
                      ],
                    )),
                SizedBox(
                    height: 280.h,
                    width: double.infinity,
                    child: Placeholder()),
                SizedBox(
                    height: 280.h,
                    width: double.infinity,
                    child: Placeholder()),
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
          fit: BoxFit.cover,
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
            child: Image(image: AssetImage("assets/image/log.png"))),
      ),
    ]);
  }
  //-------------------------------------------------------------
}
