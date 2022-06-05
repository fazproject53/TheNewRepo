import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Models/Methods/method.dart';
import '../../Models/Variables/Variables.dart';
import '../UserForm.dart';
import '../logging.dart';
import 'Reset.dart';

class ResetNewPassword extends StatefulWidget {
  final int? code;
  final String? username;
  const ResetNewPassword({
    Key? key,
    this.code,
    this.username,
  }) : super(key: key);

  @override
  _ResetNewPasswordState createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {
  bool isVisibility = false;
  bool isVisibilityNew = false;
  GlobalKey<FormState> resetNewKey = GlobalKey();
  final TextEditingController passController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
//image---------------------------------------------------------------
                child: Container(
                  width: double.infinity,
                  height: 160.h,
                  margin: EdgeInsets.all(9.w),
                  decoration: BoxDecoration(
                    // boxShadow: const [BoxShadow(blurRadius: 2)],
                    color: backBlack,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/Svg/Password Reset.svg',
                    width: 48,
                    height: 56,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 20.w),
                child: Form(
                  key: resetNewKey,
                  child: Column(
                    children: [
// new password Text field---------------------------------------------------------------
                      textField3(context, Icons.password, "كلمة المرور الجديدة",
                          12, isVisibility, passController, empty,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibility = !isVisibility;
                              });
                            },
                            icon: Icon(Icons.visibility,
                                color: deepBlack, size: 25.sp),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
//confirm new password Text field---------------------------------------------------------------
                      textField3(context, Icons.lock, "تاكيد كلمة المرور", 12,
                          isVisibilityNew, newPassController, confirm,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibilityNew = !isVisibilityNew;
                              });
                            },
                            icon: Icon(Icons.visibility,
                                color: deepBlack, size: 25.sp),
                          )),
                    ],
                  ),
                ),
              ),
//send bottom ---------------------------------------------------------------
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 20.w),
                child: gradientContainer(
                  double.infinity,
                  buttoms(
                    context,
                    "ارسال",
                    15,
                    white,
                    () {
                      if (resetNewKey.currentState?.validate() == true) {
                        resetNewPasswordMethod(widget.username!,
                            passController.text, newPassController.text);
                      }
                    },
                    evaluation: 0,
                  ),
                  height: 50,
                  color: Colors.transparent,
                  gradient: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetNewPasswordMethod(
      String username, String password, String newPassword) {
    loadingDialogue(context);
    getResetPassword(username, password, newPassword, forgetToken)
        .then((value) {
      if (value == true) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar(context, 'تم استعادة كلمة المرور بنجاح', green, done));
        goTopageReplacement(context, Logging());
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar(
            context,
            'حدث خطا اثناء استعادة كلمة السر الرجاء المحاولة مرة اخرى',
            red,
            error));
        goTopageReplacement(context, Logging());
      }
    });
  }

  String? confirm(value) {
    if (value.isEmpty) {
      return "املء الحقل اعلاه";
    }
    if (value != passController.text) {
      return "كلمة المرور غير متطابقة";
    }
    return null;
  }
}
