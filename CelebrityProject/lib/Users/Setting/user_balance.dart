///import section
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBalance extends StatelessWidget {
  const UserBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: drowAppBar('الرصيد', context),
          body: const UserBalanceHome(),
        ));
  }
}

///Balance home page
class UserBalanceHome extends StatefulWidget {
  const UserBalanceHome({Key? key}) : super(key: key);

  @override
  _UserBalanceHomeState createState() => _UserBalanceHomeState();
}

class _UserBalanceHomeState extends State<UserBalanceHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h, right: 20.w, left: 20.w),
            child: gradientContainerNoborder(
              390,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///The Total Title
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 20.w),
                    child: Row(
                      children: [
                        text(context, 'الإجمالي', 14, white),
                      ],
                    ),
                  ),

                  ///The Total Balance
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Row(
                      children: [
                        text(context, '1025.27', 24, white,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          width: 5.w,
                        ),
                        text(context, 'ر.س', 14, white,
                            fontWeight: FontWeight.w200),
                      ],
                    ),
                  ),

                  ///SizedBox
                  SizedBox(
                    height: 30.h,
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),

                        ///The Available Balance
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                text(context, 'الرصيد المتاح', 14, white)
                              ],
                            ),
                            Row(
                              children: [
                                text(context, '725', 14, white,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  width: 5.w,
                                ),
                                text(context, 'ر.س', 10, white,
                                    fontWeight: FontWeight.w200),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ///SizedBox
                      SizedBox(
                        width: 140.w,
                      ),

                      ///Suspend Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              text(context, 'الرصيد المعلق', 14, white)
                            ],
                          ),
                          Row(
                            children: [
                              text(context, '300.27', 14, white,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                width: 5.w,
                              ),
                              text(context, 'ر.س', 10, white,
                                  fontWeight: FontWeight.w200),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///SizedBox
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),

          ///SizedBox
          SizedBox(
            height: 50.h,
          ),

          ///Withdrawable Balance
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.h, right: 20.w, left: 20.w, bottom: 15.h),
              child: text(context, "رصيد السحب", 16, ligthtBlack),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 34.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 150.w,
                      height: 64.5.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: blue),
                      child: text(context, '725', 24, white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                ///SizedBox
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    text(context, 'ر.س', 14, black),
                  ],
                ),
              ],
            ),
          ),

          ///SizedBox
          SizedBox(
            height: 100.h,
          ),
          Column(
            children: [
              ///Withdrew Balance button
              padding(
                22,
                22,
                gradientContainerNoborder(getSize(context).width,
                    buttoms(context, 'سحب الرصيد', 16, white, () {})),
              ),
              SizedBox(
                height: 10.h,
              ),
              padding(
                  22,
                  22,
                  ///Recharge The Balance Button
                  gradientContainer(
                    getSize(context).width,
                    buttoms(
                      context,
                      'شحن الحساب',
                      14,
                      black,
                      () {},
                    ),
                    gradient: true,color: grey!, height: 40,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
