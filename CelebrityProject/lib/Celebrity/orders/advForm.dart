import 'dart:io';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class advForm extends StatefulWidget{
  _advFormState createState() => _advFormState();
}

class _advFormState extends State<advForm>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController coupon = new TextEditingController();

  static DateTime current = DateTime.now();
  static bool checkit =false;

  List<String> owner = ['فرد','مؤسسة','شركة'];
  List attend=['يلزم الحضور','لا يلزم الحضور'];
  List type = ['متج','خدمة'];
  List period =['صباحا','مساء'];
  final CustomGroupController cm = CustomGroupController();
  File? img;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('طلب اعلان', context),
        body:  SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                    alignment: Alignment.bottomRight,
                    children: [Container(height: 365.h,
                        width: 1000.w,
                        child: Image.asset('assets/image/featured.png', color: Colors.white.withOpacity(0.60), colorBlendMode: BlendMode.modulate,fit: BoxFit.cover,)),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('اطلب اعلان \n شخصي من ليجسي ميوزك الان',
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

                          SizedBox(height: 30,),

                          paddingg(15.w, 15.w, 12.h,textFieldDesc(context, ' الوصف الخاص بالاعلان', 14.sp, true, name,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;},),),
                          paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 14.sp, true, coupon,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;},true),),

                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding( 8,20, text(context, 'مالك الاعلان', 14, black, fontWeight: FontWeight.bold)),
                              buildCkechboxList(owner),
                            ],
                          ),
                          Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding( 8,20, text(context, 'صفة الاعلان', 14, black, fontWeight: FontWeight.bold)),
                              buildCkechboxList(attend),
                            ],
                          ),
                          Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding( 8,20, text(context, 'نوع الاعلان', 14, black, fontWeight: FontWeight.bold)),
                              buildCkechboxList(type),
                            ],
                          ), Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padding( 8,20, text(context, 'توقيت الاعلان', 14, black, fontWeight: FontWeight.bold)),
                              buildCkechboxList(period),
                            ],
                          ),
                          Divider(),

                          paddingg(15, 15, 15, uploadImg(50, 45,text(context, 'فم ارفاق ملف الاعلان', 12, black),(){pickImage(img);}),),


                          paddingg(15, 15, 15,SizedBox(height: 45.h,child: InkWell(
                            child: gradientContainerNoborder(97, Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(scheduale, color: white,),
                                SizedBox(width: 15.w,),
                                text(context, 'تاريخ الاعلان', 15.sp, white, fontWeight: FontWeight.bold),
                              ],
                            )),onTap: (){ tableCalendar(context, current);},
                          )),),


                          paddingg(0,0,12, CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: text(context,'عند طلب الاهداء، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', 10, black, fontWeight: FontWeight.bold,family:'Cairo'),
                            value: checkit,
                            selectedTileColor: black,
                            onChanged: (value) {
                              setState(() {
                                setState(() {
                                  checkit = value!;
                                });
                              });
                            },),),
                          const SizedBox(height: 30,),
                          padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'رفع الطلب', 15, white, (){})),),
                          const SizedBox(height: 30,),




                        ]),
                    ),),),
              ],
            ),
          ),),
    );


  }



}