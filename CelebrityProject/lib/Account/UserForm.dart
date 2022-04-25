import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:email_validator/email_validator.dart';

GlobalKey<FormState>userKey=GlobalKey();
GlobalKey<FormState>celebratyKey=GlobalKey();
String? userContry,celContry,celCatogary;
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

  if (value.length < 6) {
    return "كلمة المرور يجب ان تكون اكثر من 5 خانات";
  }
  return null;
}

//------------------------------------------------------------------------------------------
userForm(context) {
  return Form(
    key: userKey,
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//name------------------------------------------
      textField(
        context,
        nameIcon,
        "اسم المستخدم",
        10,
        false,
        userNameUserController,
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
        emailUserController,
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
      textField(context, passIcon, "كلمة المرور", 10, true, passUserController,
          valedpass),
      SizedBox(
        height: 15.h,
      ),
//country------------------------------------------
      drowMenu("الدولة", countryIcon, 11, ["الهند", "فلسطين", "سوريا"], (va) {
        userContry=va;
      },
          (val) {
        if (val == null) {
          return "اختر الدولة";
        } else {
          return null;
        }
      }),

      SizedBox(
        height: 15.h,
      ),
    ]),
  );
}

//CELEBRITY FORM-----------------------------------------------------------
celebratyForm(context) {
  return Form(
    key: celebratyKey,
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//name------------------------------------------
      textField(
        context,
        nameIcon,
        "اسم المستخدم",
        10,
        false,
        userNameCeleController,
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
        emailCeleController,
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
      textField(context, passIcon, "كلمة المرور", 10, true, passCeleController,
          valedpass),
      SizedBox(
        height: 15.h,
      ),
//country------------------------------------------
      drowMenu("الدولة", countryIcon, 11, ["الهند", "فلسطين", "سوريا"], (va) {
        celContry=va;
      },
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

      drowMenu("التصنيف", catogaryIcon, 11, ["كوميديا", "دراما", "طبخ"], (va) {
        celCatogary=va;
      },
          (val) {
        if (val == null) {
          return "اختر التصنيف";
        } else {
          return null;
        }
      }),

      SizedBox(
        height: 15.h,
      ),
    ]),
  );
}
