///import section
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyMain extends StatelessWidget {
  const PrivacyPolicyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("الشروط والاحكام", context),
        body: const PrivacyPolicyHome(),
      ),
    );
  }
}

///----------------------------PrivacyPolicyHome----------------------------
class PrivacyPolicyHome extends StatefulWidget {
  const PrivacyPolicyHome({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyHomeState createState() => _PrivacyPolicyHomeState();
}

class _PrivacyPolicyHomeState extends State<PrivacyPolicyHome> {
  ///Text Field
  final TextEditingController addYourAdvPP = TextEditingController();
  final TextEditingController addYourGiftingPP = TextEditingController();
  final TextEditingController addYourAdvAreaPP = TextEditingController();

  bool isVisible = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  @override
  Widget build(BuildContext context) {
    String userInput = addYourAdvPP.text;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25.h, right: 20.w),
                          child: text(
                            context,
                            "قم بإضافة الشروط والاحكام الخاصة بك",
                            19,
                            ligthtBlack,
                          ),
                        ),
                      ),

                      ///Icons Buttons with title
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(top: 20.h, right: 16.w, bottom: 20.h),
                        child: Column(
                          children: [
                            ///Adv PP
                            Row(
                              children: [
                                IconButton(
                                  icon: GradientIcon(
                                    ad,
                                    30.w,
                                    const LinearGradient(
                                      begin: Alignment(0.7, 2.0),
                                      end: Alignment(-0.69, -1.0),
                                      colors: [
                                        Color(0xff0ab3d0),
                                        Color(0xffe468ca)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  onPressed: () {
                                    ///Text field will show
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                ),
                                text(
                                  context,
                                  'سياسة الاعلان',
                                  20.sp,
                                  black,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isVisible,
                              child: Container(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Column(
                                  children: [
                                    ///Text Field
                                    paddingg(
                                      20,
                                      4,
                                      9,
                                      textFieldDescOnChange(
                                        context,
                                        'اكتب سياسة الاعلان الخاصة بك',
                                        12,
                                        false,
                                        addYourAdvPP,
                                        (String? value) {
                                          /// Validation text field
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        (String? value) {
                                          if (value == userInput) {
                                            print('No Change');
                                          } else {
                                            print('change it');
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),

                            ///Gifting PP
                            Row(
                              children: [
                                IconButton(
                                  icon: GradientIcon(
                                      ad,
                                      30.w,
                                      const LinearGradient(
                                        begin: Alignment(0.7, 2.0),
                                        end: Alignment(-0.69, -1.0),
                                        colors: [
                                          Color(0xff0ab3d0),
                                          Color(0xffe468ca)
                                        ],
                                        stops: [0.0, 1.0],
                                      )),
                                  onPressed: () {
                                    ///Text field will show
                                    setState(
                                      () {
                                        isVisible2 = !isVisible2;
                                      },
                                    );
                                  },
                                ),
                                text(
                                  context,
                                  'سياسة الاهداء',
                                  20.sp,
                                  black,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isVisible2,
                              child: Container(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Column(
                                  children: [
                                    ///Text Field
                                    paddingg(
                                      20,
                                      4,
                                      9,
                                      textFieldDescOnChange(
                                        context,
                                        'اكتب سياسة الاهداء الخاصة بك',
                                        12,
                                        false,
                                        addYourGiftingPP,
                                        (String? value) {
                                          /// Validation text field
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        (String? value) {
                                          if (value == userInput) {
                                            print('No Change');
                                          } else {
                                            print('change it');
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),

                            ///Area PP
                            Row(
                              children: [
                                IconButton(
                                  icon: GradientIcon(
                                      ad,
                                      30.w,
                                      const LinearGradient(
                                        begin: Alignment(0.7, 2.0),
                                        end: Alignment(-0.69, -1.0),
                                        colors: [
                                          Color(0xff0ab3d0),
                                          Color(0xffe468ca)
                                        ],
                                        stops: [0.0, 1.0],
                                      )),
                                  onPressed: () {
                                    ///Text field will show
                                    setState(
                                      () {
                                        isVisible3 = !isVisible3;
                                      },
                                    );
                                  },
                                ),
                                text(
                                  context,
                                  'سياسة المساحة الاعلانية',
                                  20.sp,
                                  black,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: isVisible3,
                              child: Container(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Column(
                                  children: [
                                    ///Text Field
                                    paddingg(
                                      20,
                                      4,
                                      9,
                                      textFieldDescOnChange(
                                        context,
                                        'اكتب سياسة المساحة الاعلانية الخاصة بك',
                                        12,
                                        false,
                                        addYourAdvAreaPP,
                                        (String? value) {
                                          /// Validation text field
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        (String? value) {
                                          if (value == userInput) {
                                            print('No Change');
                                          } else {
                                            print('change it');
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
