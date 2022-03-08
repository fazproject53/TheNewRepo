import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class profileInformaion extends StatefulWidget{
        _profileInformaionState createState() => _profileInformaionState();
        }

        class _profileInformaionState extends State<profileInformaion>{
        final _formKey = GlobalKey<FormState>();
        final TextEditingController name = new TextEditingController();
        final TextEditingController email = new TextEditingController();
        final TextEditingController password = new TextEditingController();
        final TextEditingController phone = new TextEditingController();
        final TextEditingController pageLink = new TextEditingController();
        final TextEditingController snapchat = new TextEditingController();
        final TextEditingController tiktok = new TextEditingController();
        final TextEditingController youtube = new TextEditingController();
        final TextEditingController instagram = new TextEditingController();
        final TextEditingController facebook = new TextEditingController();
        final TextEditingController twitter = new TextEditingController();
        final TextEditingController linkedin = new TextEditingController();

        String country = 'الدولة';
        String city = 'المدينة';
        String category = 'التصنيف';
        var citilist =[{'no': 1, 'keyword': 'المدينة'},
          {'no': 2, 'keyword': 'item1'},
          {'no': 3, 'keyword': 'item2'},
          {'no': 3, 'keyword': 'item3'},
          {'no': 3, 'keyword': 'item4'}];

        var countrylist =[{'no': 1, 'keyword': 'الدولة'},
          {'no': 2, 'keyword': 'item1'},
          {'no': 3, 'keyword': 'item2'},
          {'no': 3, 'keyword': 'item3'},
          {'no': 3, 'keyword': 'item4'}];

        var categorylist =[{'no': 1, 'keyword': 'التصنيف'},
          {'no': 2, 'keyword': 'item1'},
          {'no': 3, 'keyword': 'item2'},
          {'no': 3, 'keyword': 'item3'},
          {'no': 3, 'keyword': 'item4'}];

        List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
        List<DropdownMenuItem<Object?>> _dropdownTestItems2 = [];
        List<DropdownMenuItem<Object?>> _dropdownTestItems3 = [];
        ///_value
        var _selectedTest;
        onChangeDropdownTests(selectedTest) {
          print(selectedTest);
          setState(() {
            _selectedTest = selectedTest;
          });
        }

        var _selectedTest2;
        onChangeDropdownTests2(selectedTest) {
          print(selectedTest);
          setState(() {
            _selectedTest2 = selectedTest;
          });
        }

        var _selectedTest3;
        onChangeDropdownTests3(selectedTest) {
          print(selectedTest);
          setState(() {
            _selectedTest3 = selectedTest;
          });
        }
        @override
        void initState() {
          _dropdownTestItems =  buildDropdownTestItems(citilist);
          _dropdownTestItems2 = buildDropdownTestItems(categorylist);
          _dropdownTestItems3 = buildDropdownTestItems(countrylist);
          super.initState();
        }

        @override
        void dispose() {
          super.dispose();
        }
        List<DropdownMenuItem<Object?>> buildDropdownTestItems(List _testList) {
          List<DropdownMenuItem<Object?>> items = [];
          for (var i in _testList) {
            items.add(
              DropdownMenuItem(
                alignment: Alignment.centerRight,
                value: i,
                child: Text(i['keyword']),

              ),
            );
          }
          return items;
        }
        @override
        Widget build(BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
        appBar: drowAppBar('المعلومات الشخصية', context),
        body: SingleChildScrollView(
            child: Container(
            child: Form(
            key: _formKey,
                  child: paddingg(12, 12, 5, Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      SizedBox(height: 30.h,),
                        padding(10, 12, Container( alignment : Alignment.topRight,child: Text('قم بملئ او تعديل  معلوماتك الشخصية', style: const TextStyle(fontSize: 18, color: textBlack , fontFamily: 'Cairo'), )),),

                        //========================== form ===============================================

                        SizedBox(height: 30,),

                        paddingg(15, 15, 12,textFieldNoIcon(context, 'الاسم', 14, false, name,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'البريد الالكتروني', 14, false, email,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'كلمة المرور', 14, true, password,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'رقم الجوال', 14, false, phone,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),

                        //===========dropdown lists ==================

                        paddingg(15, 15, 12,
                          DropdownBelow(
                            itemWidth: 380.w,
                            ///text style inside the menu
                            itemTextstyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontFamily: 'Cairo',),
                            ///hint style
                            boxTextstyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: grey,
                                fontFamily: 'Cairo'),
                            ///box style
                            boxPadding:
                            EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 12.h),
                            boxWidth: 500.w,
                            boxHeight: 40.h,
                            boxDecoration: BoxDecoration(
                                color: textFieldBlack2.withOpacity(0.70),
                                borderRadius: BorderRadius.circular(8.r)),
                            ///Icons
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white54,
                            ),
                            hint:  Text(
                              country,
                              textDirection: TextDirection.rtl,
                            ),
                            value: _selectedTest3,
                            items: _dropdownTestItems3,
                            onChanged: onChangeDropdownTests3,
                          ),
                        ),
                        paddingg(15, 15, 12,
                          DropdownBelow(
                            itemWidth: 380.w,
                            ///text style inside the menu
                            itemTextstyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontFamily: 'Cairo',),
                            ///hint style
                            boxTextstyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: grey,
                                fontFamily: 'Cairo'),
                            ///box style
                            boxPadding:
                            EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 12.h),
                            boxWidth: 500.w,
                            boxHeight: 40.h,
                            boxDecoration: BoxDecoration(
                                color: textFieldBlack2.withOpacity(0.70),
                                borderRadius: BorderRadius.circular(8.r)),
                            ///Icons
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white54,
                            ),
                            hint:  Text(
                              city,
                              textDirection: TextDirection.rtl,
                            ),
                            value: _selectedTest,
                            items: _dropdownTestItems,
                            onChanged: onChangeDropdownTests,
                          ),
                        ),

                        paddingg(15, 15, 12,
                          DropdownBelow(
                            itemWidth: 380.w,
                            ///text style inside the menu
                            itemTextstyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontFamily: 'Cairo',),
                            ///hint style
                            boxTextstyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: grey,
                                fontFamily: 'Cairo'),
                            ///box style
                            boxPadding:
                            EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 12.h),
                            boxWidth: 500.w,
                            boxHeight: 40.h,
                            boxDecoration: BoxDecoration(
                                color: textFieldBlack2.withOpacity(0.70),
                                borderRadius: BorderRadius.circular(8.r)),
                            ///Icons
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white54,
                            ),
                            hint:  Text(
                              category,
                              textDirection: TextDirection.rtl,
                            ),
                            value: _selectedTest2,
                            items: _dropdownTestItems2,
                            onChanged: onChangeDropdownTests2,
                          ),
                        ),


                       //=========== end dropdown ==================================

                        paddingg(15, 15, 12,textFieldNoIcon(context, 'رابط الصفحة', 14, true, pageLink,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),


                        //===================================== اضافة روابط الصفحات =======================================================
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة سناب شات', 14, true, snapchat,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4, 47 ,
                               Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black, align: TextAlign.center))),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة تيك توك', 14, true, tiktok,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black, align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة يوتيوب', 14, true, youtube,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة الانستجرام', 14, true, instagram,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة تويتر', 14, true, twitter,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة الفيسبوك', 14, true, facebook,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, black,align: TextAlign.center))),),),),

                        //===================== button ================================

                        SizedBox(height: 30,),
                        padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'حفظ', 20, white, (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => celebratyProfile() ),
                        );})),),
                        SizedBox(height: 30,),

                ]),
              ),
            ),
        ),
        ),
        ),
    );
  }



}

