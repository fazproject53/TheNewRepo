import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:email_validator/email_validator.dart';

String? empty(value) {
  if (value.isEmpty) {
    return "املء الحقل اعلاه";
  }
  return null;
}

String? valedEmile(value) {
  if (value.trim().isEmpty) {
    return "املء الحقل اعلاه";
  }

  if (EmailValidator.validate(value.trim()) == false) {
    return "البريد الالكتروني غير صالح";
  }
  return null;
}

String? valedpass(value) {
  if (value.trim().isEmpty) {
    return "املء الحقل اعلاه";
  }

  if (value.length <6) {
    return "كلمة المرور يجب ان تكون اكثر من 5 خانات";
  }
  return null;
}

//------------------------------------------------------------------------------------------
userForm(context, bool isVisable) {
  return SingleChildScrollView(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//name------------------------------------------
    textField(
  context,
  nameIcon,
  "اسم المستخدم",
  10,
  false,
  userNameConttroller,
  empty,
  keyboardType: TextInputType.text,
  inputFormatters: [
    FilteringTextInputFormatter(RegExp(r'[a-zA-Z]|[@]|[_]|[0-9]'),
        allow: true)
  ],
    ),
    SizedBox(
  height: 15.h,
    ),
    //email------------------------------------------
    textField(
  context,
  emailIcon,
  "البريد الالكتروني",
  10,
  false,
  emailConttroller,
  valedEmile,
  keyboardType: TextInputType.emailAddress,
  inputFormatters: [
    FilteringTextInputFormatter(RegExp(r'[a-zA-Z]|[@]|[_]|[0-9]|[.]'),
        allow: true)
  ],
    ),
    SizedBox(
  height: 15.h,
    ),
    //pass------------------------------------------
    textField(
    context, passIcon, "كلمة المرور", 10, true, passConttroller, valedpass),
    SizedBox(
  height: 15.h,
    ),
//contry------------------------------------------
    drowMenu("الدولة", countryIcon, 11, ["الهند", "فلسطين", "سوريا"], (va) {},
    (val) {
  if (val == null) {
    return "اختر الدولة";
  } else {
    return null;
  }
    }),

//catogary------------------------------------------

    SizedBox(
  height: 15.h,
    ),

    Visibility(
  visible: isVisable,
  child: drowMenu(
      "التصنيف", catogaryIcon, 11, ["كوميديا", "دراما", "طبخ"], (va) {},
      (val) {
    if (val == null) {
      return "اختر التصنيف";
    } else {
      return null;
    }
  }),
    ),

    Visibility(
  visible: isVisable,
  child: SizedBox(
    height: 15.h,
  ),
    ),
  ]));
}
