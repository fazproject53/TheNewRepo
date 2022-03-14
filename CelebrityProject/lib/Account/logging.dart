import 'package:celepraty/MainScreen/main_screen_navigation.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Singup.dart';
String? currentuser;

class Logging extends StatefulWidget {
  const Logging({Key? key}) : super(key: key);

 

  @override
  State<Logging> createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
  bool isChckid = false;
  final TextEditingController lgoingEmailConttroller = new TextEditingController();
  final TextEditingController lgoingPassConttroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
//main container--------------------------------------------------
          body: container(
        double.infinity,
        double.infinity,
        0,
        0,
        black,
//==============================container===============================================================

        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 170.h),
//مرحبا بك مره اخري--------------------------------------------------
              text(context, "مرحبا بك مرة اخري", 20, white),
//تسجيل الدخول--------------------------------------------------
              text(context, "تسجيل الدخول", 15, darkWhite),
              SizedBox(
                height: 22.h,
              ),

//=============================================================================================
              padding(
                  20,
                  20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
//====================================TextFields=========================================================

//email------------------------------------------
                      textField(context, emailIcon, "البريد الالكتروني او اسم المستخدم", 10,
                          false, lgoingEmailConttroller, (val) {}),
                      SizedBox(
                        height: 15.h,
                      ),
//pass------------------------------------------
                      textField(context, passIcon, "كلمة المرور", 10, true,
                          lgoingPassConttroller, (val) {}),
                      SizedBox(
                        height: 15.h,
                      ),
//remember me && forget pass------------------------------------------
                      remmerberMe(),
                      SizedBox(
                        height: 15.h,
                      ),
//logging buttom------------------------------
                      gradientContainer(
                          347,
                          buttoms(context, 'تسجيل الدخول', 14, white, () {
                            //user logging-------------------------------
                         if(lgoingPassConttroller.text=="1"&& lgoingEmailConttroller.text=="1"){
                          setState(() {
                            currentuser="user";
                          });
                          print(currentuser);
                           Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (_) => const MainScreen()));
                           //famous logging-------------------------------
                         }else if(lgoingPassConttroller.text=="2"&& lgoingEmailConttroller.text=="2"){
                           setState(() {
                             currentuser="famous";
                           });
                           print(currentuser);
                           Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (_) => const MainScreen()));
                         }else{
                           print("امممممممممممممممممل الحقول");
                         }
                          })),
                      SizedBox(
                        height: 34.h,
                      ),
//have Account buttom-----------------------------------------------------------
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              text(context, "ليس لديك حساب بالفعل؟", 13,
                                  darkWhite),
                              SizedBox(
                                width: 7.w,
                              ),
                           InkWell( child:text(context, "انشاء حساب", 13, purple),onTap: (){goTopageReplacement(context,  SingUp());}),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
//----------------------------------------------------------------------------------------------------------------------
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }

//-------------------------------------------------------
  Widget remmerberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(child: Icon(Icons.check_circle_rounded, color: isChckid?purple:ligthtBlack, size: 23.sp),onTap:(){
             
              setState(() {
                 isChckid=!isChckid;
              });
            }),
            SizedBox(
              width: 4.w,
            ),
            text(context, 'تزكرني', 17.sp, textBlack),
          ],
        ),
        // SizedBox(
        //   width: 180.w,
        // ),
        text(context, 'هل نسيت كلمة المرور؟', 14.sp, purple),
      ],
    );
  }
//-------------------------------------------------------

}
