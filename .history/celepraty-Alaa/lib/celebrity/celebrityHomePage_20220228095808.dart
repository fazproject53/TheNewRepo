import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/celebrity/orders/advArea.dart';
import 'package:celepraty/celebrity/orders/gifttingForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/celebrity/orders/advForm.dart';

class celebrityHomePage extends StatefulWidget {
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

class _celebrityHomePageState extends State<celebrityHomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarNoIcon('الصفحة الرئيسية'),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50.h,
                  width: 900.w,
                  child: InkWell(
                      child: gradientContainerNoborder(
                          400.w,
                          Center(
                              child: text(context, 'اطلب حالا', 16, white,
                                  fontWeight: FontWeight.bold))),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=================== creating menu for the bottomsheet ===========================
/*
onTap: () {
                        showBottomSheett(context, BottomSheetMenue());
                      }

*/
  Widget BottomSheetMenue() {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 50.h,
        ),
        text(context, 'قم باختيار ما يناسبك من التالي', 22, white),
        SizedBox(
          height: 30.h,
        ),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => gifttingForm()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' طلب اهداء', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    'اطلب اهداءك الان من مشهورك المفضل',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          copun,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
        const Divider(
          color: darkWhite,
        ),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(70))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => advForm()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' طلب اعلان', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    'اطلب اعلانك الان من مشهورك المفضل  ',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10))),
                  alignment: Alignment.centerRight,
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          ad,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
        const Divider(color: darkWhite),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(50))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => advArea()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, 'طلب مساحة اعلانية', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    '                اطلب مساحتك الاعلانية الان',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10))),
                  alignment: Alignment.centerRight,
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          adArea,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
      ]),
    );
  }
}
