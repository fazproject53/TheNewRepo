import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/setting/celebratyProfile.dart';
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
        var items = ['الدولة', 'Item 2', 'Item 3', 'Item 4', 'Item 5',];
        var items2 = ['المدينة', 'Item 2', 'Item 3', 'Item 4', 'Item 5',];
        var items3 = ['التصنيف', 'Item 2', 'Item 3', 'Item 4', 'Item 5',];
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

                        paddingg(15, 15, 12,textFieldNoIcon(context, 'الاسم', 12, false, name,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'البريد الالكتروني', 12, false, email,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'كلمة المرور', 12, true, password,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),
                        paddingg(15, 15, 12,textFieldNoIcon(context, 'رقم الجوال', 12, false, phone,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),

                        //===========dropdown lists ==================

                        paddingg(15, 15, 12, Container(
                          decoration: BoxDecoration(   color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(10),),
                          child: SizedBox(
                            height: 45.h,
                            child: DropdownButtonFormField(decoration: InputDecoration.collapsed(hintText: country,),
                                  value: country, dropdownColor: textBlack, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: items.map((String items) {
                                  return DropdownMenuItem(value: items, child: paddingg(15, 15, 5,Text(items),),);}).toList(),
                                           onChanged: (String? newValue) {setState(() {country = newValue!;});},
                                           style: TextStyle(color: grey, fontSize: 14.sp),
                                           isExpanded: true, ),
                          ),
                        ),),

                        paddingg(15, 15, 12,SizedBox(
                          height: 45.h,
                          child: Container(
                            decoration: BoxDecoration(   color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(10),),
                            child: DropdownButtonFormField(  decoration: InputDecoration.collapsed(hintText: city,),value: city,dropdownColor: textBlack, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: items2.map((String items) {
                              return DropdownMenuItem(value: items, child: paddingg(15, 15, 5,Text(items),),);}).toList(),
                              onChanged: (String? newValue) {setState(() {city = newValue!;});},
                              style: TextStyle(color: grey, fontSize: 14.sp),
                              isExpanded: true,),),
                        ),),

                          paddingg(15, 15, 12, SizedBox(
                            height: 45.h,
                            child: Container(
                              decoration: BoxDecoration(   color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(10),),
                            child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: category,),value: category,dropdownColor: textBlack, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: items3.map((String items) {
                              return DropdownMenuItem(value: items, child: paddingg(15, 15, 5,Text(items),),);}).toList(),
                              onChanged: (String? newValue) {setState(() {category = newValue!;});},
                              style: TextStyle(color: grey, fontSize: 14.sp),
                              isExpanded: true,),),
                          ),),

                       //=========== end dropdown ==================================

                        paddingg(15, 15, 12,textFieldNoIcon(context, 'رابط الصفحة', 14, true, pageLink,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},false),),


                        //===================================== اضافة روابط الصفحات =======================================================
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة سناب شات', 14, true, snapchat,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4, 47 ,
                               Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white, align: TextAlign.center))),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة تيك توك', 14, true, tiktok,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white, align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة يوتيوب', 14, true, youtube,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة الانستجرام', 14, true, instagram,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة الفيسبوك', 14, true, facebook,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة تويتر', 14, true, twitter,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47 ,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white,align: TextAlign.center))),),),),
                        textFeildWithButton(context, textFieldNoIcon2(context, 'رابط صفحة لينكدان', 14, true, linkedin,(String? value) {if (value == null || value.isEmpty) {
                          return 'Please enter some text';} return null;},), gradientContainerWithHeight(getSize(context).width/4,47,
                          Container(child: Center(child: InkWell(onTap: (){}, child: text(context, 'اضافة', 14, white,align: TextAlign.center))),),),),


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
  }}