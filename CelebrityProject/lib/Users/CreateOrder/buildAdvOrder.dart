import 'dart:io';
import 'package:celepraty/MainScreen/main_screen_navigation.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class buildAdvOrder extends StatefulWidget{
  _buildAdvOrderState createState() => _buildAdvOrderState();
}

class _buildAdvOrderState extends State<buildAdvOrder> {
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  int current =0;
  bool isCompleted = false;
  final TextEditingController subject = new TextEditingController();
  final TextEditingController desc = new TextEditingController();
  final TextEditingController pageLink = new TextEditingController();
  final TextEditingController coupon = new TextEditingController();

  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController couponcode = new TextEditingController();

   static double ww =0.0;
  List sampleData = [];
  DateTime currentt = DateTime.now();
  static List<int> selectedIndex = [];
  String balancen = 'الميزانية ';
  String cityn = 'المدينة';
  String categoryn = 'التصنيف';

  List<String> balance = ['الميزانية ','الميزانية ',' 2',' 3 '];
  List<String> city = ['المدينة','المدينة','المدينة2','3المدينة'];
  var category = ['التصنيف','2','3','التصنيف'];

  List<String> owner = ['فرد','مؤسسة','شركة'];
  List attend=['يلزم الحضور','لا يلزم الحضور'];
  List type = ['متج','خدمة'];
  List verify =['غير موثق','موثق'];
  List human =['انثى','ذكر'];
  List period =['صباحا','مساء'];
  bool checkit = false;
  bool checkit2 = false;
  File? img;
  @override
  Widget build(BuildContext context) {
    setState(() {
      ww = getSize(context).width;
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: isCompleted? null : drowAppBar('انشاء طلب اعلان', context),
        body: isCompleted? MainScreen() :Stepper(
          margin: EdgeInsets.symmetric(horizontal: 24),
          steps: getSteps(),
          type: StepperType.horizontal,
          onStepContinue: (){
            bool isLastStep = current == getSteps().length-1;
            if(isLastStep){ setState(() {
              isCompleted = true;
            }); }
            setState(() {
              current == 1? selectedIndex.isEmpty? null: current +=1:current +=1;});},
          onStepCancel:  (){ current == 0? null : setState(() { current -=1;selectedIndex.clear();});},
          currentStep: current,
          onStepTapped: (value) => setState(() {
            current = value;
          }),
          controlsBuilder: (context, controls) {
            return Row(
              children: [
                TextButton(onPressed: controls.onStepContinue,
                child:(current != getSteps().length-1 && current != getSteps().length-3)?const Text('متابعة'):current != getSteps().length-3 && checkit2? const Text('تاكيد'):
                checkit == true && current != getSteps().length-1?const Text('متابعة'): const Text(''), ),
                TextButton(onPressed: controls.onStepCancel,
                child: current != getSteps().length-3? const Text('رجوع'): const Text(''),
                  ),
              ],
            );
          },

        ),

      ),
    );
  }
List<Step> getSteps(){
    return [
      Step(
        state: current > 0? StepState.complete : StepState.indexed,
        title: Text('خطوة 1'),
        content: stepOne(),
        isActive: current >= 0,

      ),
      Step(
        state: current > 1? StepState.complete : StepState.indexed,
        title: Text('خطوة 2'),
        content: stepTwo(),
        isActive: current >= 1,),

      Step(
        state: current > 1? StepState.complete : StepState.indexed,
        title: Text('خطوة 3'),
        content:  stepThree(),
        isActive: current >= 2,),
    ];
  }


  stepOne(){
    return SingleChildScrollView(
      child: Container( child: Form(
        key: _formKey2,
        child: paddingg(8, 8, 5, Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h,),
              padding(10, 12, Container( alignment : Alignment.topRight,child:  text(context, ' قم بملئ   \n البيانات التالية',18,textBlack,fontWeight: FontWeight.bold,
                family: 'DINNextLTArabic-Regular-2', )),),

              //========================== form ===============================================


              paddingg(10, 10, 12,SizedBox(
                height: 45.h,
                child: Container(
                  decoration: BoxDecoration( color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(8),),
                  child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: categoryn,),value: categoryn, dropdownColor: textBlack,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items:  ['التصنيف','2','3'].map((String item) {
                    return DropdownMenuItem(
                      alignment: Alignment.centerRight,
                      value: item, child: paddingg(15.w, 15.w, 5.h,Text(item),),);}).toList(),
                    onChanged: (String? newValue) {setState(() {categoryn = newValue!;});},
                    style: TextStyle(color: grey, fontSize: 14.sp),
                    isExpanded: true,),),
              ),),


              paddingg(10, 10, 12,SizedBox(
                height: 45.h,
                child: Container(
                  decoration: BoxDecoration( color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(8),),
                  child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: balancen,),value: balancen, dropdownColor: textBlack,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items: ['الميزانية ',' 2',' 3 '].map((String item) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: item, child: paddingg(15.w, 15.w, 5.h,Text(item),),);}).toList(),
                    onChanged: (String? newValue) {setState(() {balancen = newValue!;});},
                    style: TextStyle(color: grey, fontSize: 14.sp),
                    isExpanded: true,),),
              ),),

              paddingg(10, 10,12,SizedBox(
                height: 45.h,
                width: 100.w,
                child: Container(
                  decoration: BoxDecoration( color: textFieldBlack2.withOpacity(0.70),  borderRadius: BorderRadius.circular(8),),
                  child: DropdownButtonFormField( decoration: InputDecoration.collapsed(hintText: categoryn,),value: cityn, dropdownColor: textBlack,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,), items:  ['المدينة','المدينة2','3المدينة'].map((String item) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: item, child: paddingg(15.w, 15.w, 5.h,Text( item),),);}).toList(), onChanged: (String? newValue) {setState(() {categoryn = newValue!;});},
                    style: TextStyle(color: grey, fontSize: 14.sp),
                    isExpanded: true,),),
              ),),


              paddingg(10.w, 10.w, 12.h,textFieldNoIcon(context, 'موضوع الاعلان', 12.sp, true, subject,(String? value) {if (value == null || value.isEmpty) {
                return 'Please enter some text';} return null;},false),),
              paddingg(10.w, 10.w, 12.h,textFieldDesc(context, 'وصف الاعلان', 12.sp, true, desc,(String? value) {if (value == null || value.isEmpty) {
                return 'Please enter some text';} return null;},),),
              paddingg(10.w, 10.w, 12.h,textFieldNoIcon(context, 'رابط صفحة الاعلان', 12.sp, true, pageLink,(String? value) {if (value == null || value.isEmpty) {
                return 'Please enter some text';} return null;},false),),


              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(10, 10, text(context, 'حساب المشهور', 14, black, fontWeight: FontWeight.bold)),
                  buildCkechboxList(verify),
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(10, 10, text(context, 'الجنس', 14, black, fontWeight: FontWeight.bold)),
                  buildCkechboxList(human),
                ],
              ),
              Divider(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(10, 10, text(context, 'مالك الاعلان', 14, black, fontWeight: FontWeight.bold)),
                  buildCkechboxList2(owner),
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(10, 10, text(context, 'صفة الاعلان', 14, black, fontWeight: FontWeight.bold)),
                  buildCkechboxList(attend),
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padding(10, 10, text(context, 'نوع الاعلان', 14, black, fontWeight: FontWeight.bold)),
                  buildCkechboxList(type),
                ],
              ), Divider(),


              paddingg(10, 10, 15, uploadImg(50, 45,text(context, 'فم ارفاق ملف الاعلان', 12, black),(){pickImage(img);}),),


              paddingg(10, 10,15,SizedBox(height: 45.h,child: InkWell(
                child: gradientContainerNoborder(97, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(scheduale, color: white,),
                    SizedBox(width: 15.w,),
                    text(context, 'تاريخ الاعلان', 15.sp, white, fontWeight: FontWeight.bold),
                  ],
                )),onTap: (){ tableCalendar(context, currentt);},
              )),),


              paddingg(0,0,12, CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: RichText(
                  text: const TextSpan(children: [
                    TextSpan(text: ' عند الطلب ، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', style: TextStyle(color: black, fontFamily: 'Cairo',fontSize: 12)),
                    TextSpan(text: 'الشروط والاحكام', style: TextStyle(color: blue, fontFamily: 'Cairo',fontSize: 12))
                  ]
                )
                ),

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




            ]),
        ),),),
    );
  }

  stepTwo(){
    return  SizedBox(
                child: GridView.count(
                 physics: ScrollPhysics(),
                  crossAxisCount:2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(6, (index) {
                    return  InkWell(
                        onTap: (){if(!selectedIndex.contains(index)){selectedIndex.add(index);}else{selectedIndex.remove(index);} setState(() {
                    });},
                    child: Container(
                        height: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                            children: [
                           ClipRRect(borderRadius: BorderRadius.circular( 8),child: Image.asset('assets/image/featured.png'
                             ,color: selectedIndex.contains(index)? deepBlack.withOpacity(0.50):deepwhite.withOpacity(0.80) , colorBlendMode: BlendMode.modulate, fit: BoxFit.fill,height: double.infinity,),
                           ),

                              Container(
                                 alignment: Alignment.bottomRight,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children:  [
                                     Container( child: FittedBox(fit: BoxFit.fitWidth,child: text(context,'مروان بابلو'  , ww > 400? 30: 12, white, fontWeight: FontWeight.bold)), alignment: Alignment.centerRight, margin: EdgeInsets.only(right: 8.w),),
                                     Container(child: text(context,'تصنيف : مطرب' , 10, white), alignment: Alignment.centerRight, margin: EdgeInsets.only(right: 8.w)),
                                     Container(child: text(context,'سعرالاعلان : ابتداءا من ***' , 10, white), alignment: Alignment.centerRight, margin: EdgeInsets.only(right: 8.w)),
                                   SizedBox(height: 10.h,)],
                                 ),
                               ),
                            ],
                          ),
                    ),
                    );
                  }),
    ),
              );


  }

  stepThree(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
              children: [
                Container(
                    height: 250.h,
                    width: 1000.w,
                    child: Image.asset('assets/image/featured.png', color: Colors.white.withOpacity(0.60), colorBlendMode: BlendMode.modulate,fit: BoxFit.fill,)),

                Container(
                  margin: EdgeInsets.only(bottom: 10.h,right: 10.h),
                  child: const Text('اطلب اعلان \n شخصي من ليجسي ميوزك الان',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: white , fontFamily: 'DINNextLTArabic-Regular-2'), ),

                  )],),
          Container(
            child: Form(
              key: _formKey3,
              child: paddingg(12, 12, 5, Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.h,),
                    padding(10, 12, Container( alignment : Alignment.topRight,child:  text(context, ' قم بملئ   \n البيانات التالية',18,textBlack,fontWeight: FontWeight.bold,
                      family: 'DINNextLTArabic-Regular-2', )),),

                    //========================== form ===============================================

                    SizedBox(height: 10,),

                    paddingg(15.w, 15.w, 12.h,textFieldDesc(context, 'وصف الاعلان', 12.sp, true, description,(String? value) {if (value == null || value.isEmpty) {
                      return 'Please enter some text';} return null;},),),
                    paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 12.sp, true, couponcode,(String? value) {if (value == null || value.isEmpty) {
                      return 'Please enter some text';} return null;},false),),

                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        padding( 8,20, text(context, 'مالك الاعلان', 14, black, fontWeight: FontWeight.bold)),
                        buildCkechboxList2(owner),
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
                      )),onTap: (){ tableCalendar(context, currentt);},
                    )),),


                    paddingg(0,0,12, CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: RichText(
                          text: const TextSpan(children: [
                            TextSpan(text: ' عند الطلب ، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', style: TextStyle(color: black, fontFamily: 'Cairo',fontSize: 12)),
                            TextSpan(text: 'الشروط والاحكام', style: TextStyle(color: blue, fontFamily: 'Cairo',fontSize: 12))
                          ]
                          )
                      ),

                      value: checkit2,
                      selectedTileColor: black,
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            checkit2 = value!;
                          });
                        });
                      },),),
                    SizedBox(height: 30.h,),



                  ]),
              ),),),

    ]),
    );
  }
  buildCompleted() {
  }

}