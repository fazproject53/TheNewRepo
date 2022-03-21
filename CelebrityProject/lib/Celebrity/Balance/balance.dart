///import section
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceMain extends StatelessWidget {
  const BalanceMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('الرصيد', context),
        body: const BalanceHome(),
      ),
    );
  }
}
///-------------------------balance section-------------------------
class BalanceHome extends StatefulWidget {
  const BalanceHome({Key? key}) : super(key: key);

  @override
  _BalanceHomeState createState() => _BalanceHomeState();
}

class _BalanceHomeState extends State<BalanceHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              child: text(context, "الرصيد الخاص بك", 19, ligthtBlack),
            ),
          ),

          ///The Account Balance
          Padding(
            padding: EdgeInsets.only(
                top: 16.h, right: 20.w, left: 20.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Icon
                        GradientIcon(
                            payment,
                            27.w,
                            const LinearGradient(
                              begin: Alignment(0.7, 2.0),
                              end: Alignment(-0.69, -1.0),
                              colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                              stops: [0.0, 1.0],
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        ///Text
                        text(
                          context,
                          'رصيد الحساب',
                          20.sp,
                          black,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: grey,
                    height: 20.h,
                    thickness: 0.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.w,left: 10.w,bottom: 10.h),
                    child: text(context, "500 ر.س", 16, ligthtBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          ///The Suspend Balance
          Padding(
            padding: EdgeInsets.only(
                top: 16.h, right: 20.w, left: 20.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Icon
                        GradientIcon(
                            payment,
                            27.w,
                            const LinearGradient(
                              begin: Alignment(0.7, 2.0),
                              end: Alignment(-0.69, -1.0),
                              colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                              stops: [0.0, 1.0],
                            )),
                        SizedBox(
                          width: 2.w,
                        ),
                        ///Text
                        text(
                          context,
                          'الرصيد المعلق',
                          20.sp,
                          black,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: grey,
                    height: 20.h,
                    thickness: 0.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.w,left: 10.w, bottom: 10.h),
                      child: text(context, "500 ر.س", 16, ligthtBlack,
                          fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          ///Withdrew Money Button
          padding(
            22,
            22,
            gradientContainerNoborder(getSize(context).width,
                buttoms(context, 'سحب الرصيد', 20, white, () {})),
          ),
        ],
      ),
    );
  }
}
