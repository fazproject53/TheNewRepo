import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class gifttingForm extends StatefulWidget{
  _gifttingFormState createState() => _gifttingFormState();
}

class _gifttingFormState extends State<gifttingForm>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mycontroller = new TextEditingController();
  DateTime current = DateTime.now();
  String ocassion = 'اختر المناسبة الخاصة';
  String type = 'نوع الاهداء';
  var ocassionlist =[{'no': 1, 'keyword': 'item'},
    {'no': 2, 'keyword': 'item2'},
    {'no': 3, 'keyword': 'item3'},
    {'no': 3, 'keyword': 'item4'},];

  var typelist =[{'no': 1, 'keyword': 'فيديو'},
    {'no': 2, 'keyword': 'صوت'},
    {'no': 3, 'keyword': 'صورة'},];
  static bool check =false;

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
        appBar: drowAppBar('طلب اهداء', context),
          body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [Container(height: 365.h,
                 width: 1000.w,
                 child: Image.asset('assets/image/featured.png', color: Colors.white.withOpacity(0.60), colorBlendMode: BlendMode.modulate,fit: BoxFit.cover,)),
                   const Padding(
                     padding: EdgeInsets.all(20.0),
                     child: Text('اطلب اهداء \n شخصي من ليجسي ميوزك الان',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: white , fontFamily: 'DINNextLTArabic-Regular-2'), ),
                   ),
                ]),
              Container(
              child: Form(
              key: _formKey,
              child: paddingg(12, 12, 5, Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              SizedBox(height: 20.h,),
                padding(10, 12, Container( alignment : Alignment.topRight,child:  text(context, ' قم بملئ   البيانات التالية',18,textBlack,fontWeight: FontWeight.bold,
                  family: 'DINNextLTArabic-Regular-2', )),),

      //========================== form ===============================================

                const SizedBox(height: 30,),

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
                      ocassion,
                      textDirection: TextDirection.rtl,
                    ),
                    value: _selectedTest,
                    items: _dropdownTestItem,
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
                      type,
                      textDirection: TextDirection.rtl,
                    ),
                    value: _selectedTest2,
                    items: _dropdownTestItem2,
                    onChanged: onChangeDropdownTests2,
                  ),
                ),


                Row(
                  children: [
                    Expanded(
                        child: paddingg(3.w, 15.w, 12.h,textFieldNoIcon(context, 'من', 14.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),),
                    Expanded(
                      child: paddingg(15.w, 3.w, 12.h,textFieldNoIcon(context, 'الى', 14.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                        return 'Please enter some text';} return null;}, false),),
                    ),

                  ],
                ),

                paddingg(15.w, 15.w, 12.h,textFieldDesc(context, 'تفاصيل الاهداء', 14.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                  return 'Please enter some text';} return null;},),),
                paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 14.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                  return 'Please enter some text';} return null;},true),),


                paddingg(15.w, 15.w, 15.h,SizedBox(height: 45.h,child: InkWell(
                  child: gradientContainerNoborder(50.w, Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(scheduale, color: white,),
                      SizedBox(width: 15.w,),
                      text(context, 'تاريخ الاهداء', 15.sp, white, fontWeight: FontWeight.bold),
                    ],
                  )),onTap: (){ tableCalendar(context, current);},
                )),),


                paddingg(0,0,12.h, CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: text(context,'عند طلب الاهداء، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', 10, black, fontWeight: FontWeight.bold,family:'Cairo'),
                  value: check,
                  selectedTileColor: black,
                  onChanged: (value) {
                    setState(() {
                      setState(() {
                        check = value!;
                      });
                    });
                  },),),
                 SizedBox(height: 30.h,),
                padding(15.w, 15.w, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'رفع الطلب', 15, white, (){})),),
                 SizedBox(height: 30.h,),




      ]),
              ),),),
            ],
          ),
          ),),
    );


  }
  List<DropdownMenuItem<Object?>> _dropdownTestItem = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItem2 = [];
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

  @override
  void initState() {
    _dropdownTestItem = buildDropdownTestItems(ocassionlist);
    _dropdownTestItem2 = buildDropdownTestItems(typelist);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}