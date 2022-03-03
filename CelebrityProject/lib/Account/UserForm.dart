import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var country = '';
userForm(context, bool isVisable) {
  return Form(
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//name------------------------------------------
    textField(context, nameIcon, "اسم المستخدم", 10, false, nameConttroller,
        (val) {}),
    SizedBox(
      height: 15.h,
    ),
//contry------------------------------------------
    textField(
        context, countryIcon, "الدولة", 10, false, nameConttroller, (val) {},
        suffixIcon: const Icon(Icons.arrow_drop_down, color: deepBlack),
        onTap: () {}),

//catogary------------------------------------------

    SizedBox(
      height: 15.h,
    ),

    Visibility(
      visible: isVisable,
      child: textField(context, catogaryIcon, "التصنيف", 10, false,
          nameConttroller, (val) {},
          suffixIcon: Icon(Icons.arrow_drop_down, color: deepBlack),
          onTap: () {}),
    ),

    Visibility(
      visible: isVisable,
      child: SizedBox(
        height: 15.h,
      ),
    ),
//email------------------------------------------
    textField(context, emailIcon, "البريد الالكتروني", 10, false,
        emailConttroller, (val) {}),
    SizedBox(
      height: 15.h,
    ),
//pass------------------------------------------
    textField(
        context, passIcon, "كلمة المرور", 10, false, passConttroller, (val) {}),
    SizedBox(
      height: 15.h,
    ),
  ])));
}
