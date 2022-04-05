///import section
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingMain extends StatelessWidget {
  const PricingMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('التسعير', context),
        body: const PricingHome(),
      ),
    );
  }
}

///----------------------------- Pricing HomePage -----------------------------
class PricingHome extends StatefulWidget {
  const PricingHome({Key? key}) : super(key: key);

  @override
  _PricingHomeState createState() => _PricingHomeState();
}

class _PricingHomeState extends State<PricingHome> {
  ///Text Filed
  final TextEditingController pricingAd = TextEditingController();
  final TextEditingController pricingAd1 = TextEditingController();
  final TextEditingController pricingGiftPhoto = TextEditingController();
  final TextEditingController pricingGiftVideo = TextEditingController();
  final TextEditingController pricingGiftVoice = TextEditingController();
  final TextEditingController pricingArea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w),
                child: text(context, "التسعير الخاص بك", 19, ligthtBlack),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            ///Ad
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, bottom: 10.h, right: 8.w, left: 8.w),
              child: Container(
                height: 120.h,
                width: 370.w,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.r,
                        offset: Offset(0, 15), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    )),

                ///For text
                child: Padding(
                  padding: EdgeInsets.only(top: 7.h, right: 10.w, left: 10.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GradientIcon(
                              orders,
                              25.w,
                              const LinearGradient(
                                begin: Alignment(0.7, 2.0),
                                end: Alignment(-0.69, -1.0),
                                colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                stops: [0.0, 1.0],
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          text(context, 'الإعلان', 16.sp, black,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Text
                          text(context, 'من', 16, grey!),

                          ///Text Filed
                          textFieldSmall(
                            context,
                            '2000 ر.س',
                            12,
                            false,
                            pricingAd1,
                            (String? value) {
                              /// Validation text field
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          text(context, 'الى', 16, grey!),

                          ///Text Filed
                          textFieldSmall(
                            context,
                            '5000 ر.س',
                            12,
                            false,
                            pricingAd,
                            (String? value) {
                              /// Validation text field
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          text(context, 'ر.س', 16.sp, black),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///Gifting
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, bottom: 10.h, right: 8.w, left: 8.w),
              child: Container(
                height: 200.h,
                width: 370.w,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.r,
                        offset: Offset(0, 15), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    )),
                child: Padding(
                    padding: EdgeInsets.only(top: 7.h, right: 25.w, left: 25.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GradientIcon(
                                gift,
                                25.w,
                                const LinearGradient(
                                  begin: Alignment(0.7, 2.0),
                                  end: Alignment(-0.69, -1.0),
                                  colors: [
                                    Color(0xff0ab3d0),
                                    Color(0xffe468ca)
                                  ],
                                  stops: [0.0, 1.0],
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            text(context, 'الإهداء', 16.sp, black,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        ///Photo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Text
                            text(context, 'صورة', 16, grey!),
                            SizedBox(
                              width: 20.w,
                            ),

                            ///Text Filed
                            textFieldSmall(
                              context,
                              '2000 ر.س',
                              12,
                              false,
                              pricingGiftPhoto,
                              (String? value) {
                                /// Validation text field
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              suffixIcon: MyTooltip(
                                  message: 'التسعير الخاص بصورة واحدة',
                                  child: Icon(infoIcon, size: 15,)
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),

                            ///Text
                            text(context, 'ر.س', 16.sp, black),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        ///Video
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Text
                            text(context, 'فيديو', 16, grey!),
                            SizedBox(
                              width: 20.w,
                            ),
                            ///Text Filed
                            textFieldSmall(
                              context,
                              '2000 ر.س',
                              12,
                              false,
                              pricingGiftVideo,
                              (String? value) {
                                /// Validation text field
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              suffixIcon: MyTooltip(
                                  message: 'التسعير الخاص بفيديو مدته ٤٥ ثانية',
                                  child: Icon(infoIcon, size: 15,)
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            ///Text
                            text(context, 'ر.س', 16.sp, black),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        ///Voice
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Text
                            text(context, 'صوت', 16, grey!),
                            SizedBox(
                              width: 20.w,
                            ),

                            ///Text Filed
                            textFieldSmall(
                              context,
                              '2000 ر.س',
                              12,
                              false,
                              pricingGiftVoice,
                              (String? value) {
                                /// Validation text field
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              suffixIcon: MyTooltip(
                                  message: 'التسعير الخاص بصوت مدته ٣٠ ثانية',
                                  child: Icon(infoIcon, size: 15,)
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            ///Text
                            text(context, 'ر.س', 16.sp, black),
                          ],
                        ),
                      ],
                    )),
              ),
            ),

            ///Area
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, bottom: 10.h, right: 8.w, left: 8.w),
              child: Container(
                height: 120.h,
                width: 370.w,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.r,
                        offset: Offset(0, 15), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    )),

                ///For text
                child: Padding(
                    padding: EdgeInsets.only(top: 7.h, right: 25.w, left: 25.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GradientIcon(
                                adArea,
                                25.w,
                                const LinearGradient(
                                  begin: Alignment(0.7, 2.0),
                                  end: Alignment(-0.69, -1.0),
                                  colors: [
                                    Color(0xff0ab3d0),
                                    Color(0xffe468ca)
                                  ],
                                  stops: [0.0, 1.0],
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            text(context, 'المساحة الاعلانية', 16.sp, black,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 55.w,
                            ),

                            ///Text Filed
                            textFieldSmall(
                              context,
                              '2000 ر.س',
                              12,
                              false,
                              pricingArea,
                              (String? value) {
                                /// Validation text field
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              suffixIcon: MyTooltip(
                                  message: 'التسعير الخاص بمساحة اعلانية لمدة ٢٤ ساعة',
                                  child: Icon(infoIcon, size: 15,)
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            text(context, 'ر.س', 16.sp, black),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///Tooltip
class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}