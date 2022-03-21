import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class userInformation extends StatefulWidget{
  _userInformationState createState() => _userInformationState();
}

class _userInformationState extends State<userInformation>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController repassword = new TextEditingController();
  final TextEditingController phone = new TextEditingController();

bool hidden = true;
bool hidden2 = true;
  String country = 'الدولة';
  String city = 'المدينة';

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


  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItems3 = [];
  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
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
          alignment: Alignment.topRight,
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
                    paddingg(15, 15, 12,textFieldNoIcon(context, 'رقم الجوال', 14, false, phone,(String? value) {if (value == null || value.isEmpty) {
                      return 'Please enter some text';} return null;},false),),
                    paddingg(15, 15, 12,textFieldPassword(context, 'كلمة المرور', 14, hidden, password,(String? value) {if (value == null || value.isEmpty) {
                      return 'Please enter some text';} return null;},false),),
                    paddingg(15, 15, 12,textFieldPassword2(context, 'اعادة ضبط كلمة المرور ', 14, hidden2, repassword,(String? value) {if (value == null || value.isEmpty) {
                      return 'Please enter some text';} return null;},false),),

                    //===========dropdown lists ==================

                    paddingg(15, 15, 12,
                      DropdownBelow(
                        dropdownColor: newGrey,
                        itemWidth: 370.w,
                        ///text style inside the menu
                        itemTextstyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: white,
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
                        boxHeight: 45.h,
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
                        dropdownColor: newGrey,
                        itemWidth: 370.w,
                        ///text style inside the menu
                        itemTextstyle: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: white,
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
                        boxHeight: 45.h,
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



                    //=========== end dropdown ==================================

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

  Widget textFieldPassword(
      context,
      String key,
      double fontSize,
      bool hintPass,
      TextEditingController mycontroller,
      myvali,
      isOptional,
      ) {
    return TextFormField(
      obscureText: hintPass? true :false ,
      validator: myvali,
      controller: mycontroller,
      style: TextStyle(color: white, fontSize: fontSize.sp, fontFamily: 'Cairo'),
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          helperText: isOptional? 'اختياري': null,
          helperStyle: TextStyle(color: pink, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          hintStyle: TextStyle(color: grey, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          fillColor: textFieldBlack2.withOpacity(0.70),
          labelStyle: TextStyle(color: white, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: pink,width: 1)),
          suffixIcon: hidden? IconButton(onPressed: (){setState(() {
            hidden = false;
          });}, icon: Icon(hide, color: lightGrey,)):IconButton(onPressed: (){setState(() {
            hidden = true;
          });}, icon: Icon(show, color: lightGrey)),
          hintText: key,
          contentPadding: EdgeInsets.all(10.h)),
    );

  }

  Widget textFieldPassword2(
      context,
      String key,
      double fontSize,
      bool hintPass,
      TextEditingController mycontroller,
      myvali,
      isOptional,
      ) {
    return TextFormField(
      obscureText: hintPass? true :false ,
      validator: myvali,
      controller: mycontroller,
      style: TextStyle(color: white, fontSize: fontSize.sp, fontFamily: 'Cairo'),
      decoration: InputDecoration(
          isDense: false,
          filled: true,
          helperText: isOptional? 'اختياري': null,
          helperStyle: TextStyle(color: pink, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          hintStyle: TextStyle(color: grey, fontSize: fontSize.sp, fontFamily: 'Cairo'),
          fillColor: textFieldBlack2.withOpacity(0.70),
          labelStyle: TextStyle(color: white, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: pink,width: 1)),
          suffixIcon: hidden2? IconButton(onPressed: (){setState(() {
            hidden2 = false;
          });}, icon: Icon(hide, color: lightGrey,)):IconButton(onPressed: (){setState(() {
            hidden2 = true;
          });}, icon: Icon(show, color: lightGrey)),
          hintText: key,
          contentPadding: EdgeInsets.all(10.h)),
    );

  }

}

