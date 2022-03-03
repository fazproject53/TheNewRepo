import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
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
  String ocassion = 'المناسبة';
  String type = 'نوع الاهداء';
  var items2 = ['المناسبة', 'Item 2', 'Item 3', 'Item 4', 'Item 5',];
  var items3 = ['نوع الاهداء', 'فيديو', 'صوت', 'صورة'];
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


                paddingg(15, 15, 12,SizedBox(
                  height: 45.h,
                  child: Container(
                    decoration: BoxDecoration( color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(8),),
                    child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: ocassion,),value: ocassion, dropdownColor: textBlack, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: items2.map((String items) {
                      return DropdownMenuItem(value: items, child: paddingg(15.w, 15.w, 5.h,Text(items),),);}).toList(),
                      onChanged: (String? newValue) {setState(() {ocassion = newValue!;});},
                      style: TextStyle(color: grey, fontSize: 14.sp),
                      isExpanded: true,),),
                ),),

                paddingg(15, 15, 12,SizedBox(
                  height: 45.h,
                  child: Container(
                    decoration: BoxDecoration( color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(8),),
                    child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: type,),value: type, dropdownColor: textBlack, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: items3.map((String items) {
                      return DropdownMenuItem(value: items, child: paddingg(15.w, 15.w, 5.h,Text(items),),);}).toList(),
                      onChanged: (String? newValue) {setState(() {type = newValue!;});},
                      style: TextStyle(color: grey, fontSize: 14.sp),
                      isExpanded: true,),),
                ),),

                Row(
                  children: [
                    Expanded(
                        child: paddingg(3.w, 15.w, 12.h,textFieldNoIcon(context, 'من', 12.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),),
                    Expanded(
                      child: paddingg(15.w, 3.w, 12.h,textFieldNoIcon(context, 'الى', 12.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                        return 'Please enter some text';} return null;}, false),),
                    ),

                  ],
                ),

                paddingg(15.w, 15.w, 12.h,textFieldDesc(context, 'تفاصيل الاهداء', 12.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                  return 'Please enter some text';} return null;},),),
                paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 12.sp, false, mycontroller,(String? value) {if (value == null || value.isEmpty) {
                  return 'Please enter some text';} return null;},false),),


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

}