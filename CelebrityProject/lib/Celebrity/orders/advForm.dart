import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

class advForm extends StatefulWidget{
  final String? id;
  const advForm({Key? key,  this.id}) : super(key: key);
  _advFormState createState() => _advFormState();
}

class _advFormState extends State<advForm>{
  int? _value = 1;
  bool isValue1 = false;

  int? _value2 = 1;
  int? _value3 = 1;
  int? _value4 = 1;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = new TextEditingController();
  final TextEditingController coupon = new TextEditingController();
  List<int> saveList = [];
   DateTime current = DateTime.now();
   bool checkit =false;
  bool warn2 = false;
  bool datewarn2 = false;
  bool warnimage = false;

  File? file;
  Stream? streamm;
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
                          style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, color: white , fontFamily: 'Cairo'), ),
                      ),
                    ]),
                Container(
                  child: Form(
                    key: _formKey,
                    child: paddingg(12, 12, 5, Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20.h,),
                          padding(10, 12, Container( alignment : Alignment.topRight,child:  text(context, ' قم بملئ   البيانات التالية',18,textBlack,fontWeight: FontWeight.normal,
                            family: 'Cairo', )),),

                          //========================== form ===============================================

                          SizedBox(height: 30,),

                          paddingg(15.w, 15.w, 12.h,textFieldDesc(context, ' الوصف الخاص بالاعلان', 14.sp, true, description,(String? value) {
                            if (value == null || value.isEmpty) {
                            return 'حقل اجباري';} return null;},),),
                          paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 14.sp, false, coupon,(String? value) {
                           return null;},true),),

                          SizedBox(height: 20,),

                          padding( 8,20, text(context, 'مالك الاعلان', 14, black, fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.only(
                                top: 3.h, right: 2.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 1,
                                          groupValue:
                                          _value,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value =
                                                  value;
                                              isValue1 =
                                              false;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "فرد",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 2,
                                          groupValue:
                                          _value,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value =
                                                  value;
                                              isValue1 =
                                              true;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "مؤسسة",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 3,
                                          groupValue:
                                          _value,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value =
                                                  value;
                                              isValue1 =
                                              true;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "شركة",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          padding( 8,20, text(context, 'صفة الاعلان', 14, black, fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.only(
                                top: 3.h, right: 2.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 1,
                                          groupValue:
                                          _value2,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value2 =
                                                  value;
                                              isValue1 =
                                              false;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "يلزم الحضور",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 2,
                                          groupValue:
                                          _value2,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value2 =
                                                  value;
                                              isValue1 =
                                              true;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "لا يلزم الحضور",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          padding( 8,20, text(context, 'نوع الاعلان', 14, black, fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.only(
                                top: 3.h, right: 2.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 1,
                                          groupValue:
                                          _value3,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value3 =
                                                  value;
                                              isValue1 =
                                              false;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "خدمة",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 2,
                                          groupValue:
                                          _value3,
                                          activeColor:
                                          blue,
                                          onChanged:
                                              (value) {
                                            setState(() {
                                              _value3 =
                                                  value;
                                              isValue1 =
                                              true;
                                            });
                                          }),
                                    ),
                                    text(
                                        context,
                                        "منتج",
                                        14,
                                        ligthtBlack,
                                        family:
                                        'DINNextLTArabic'),
                                  ],
                                ),
                              ],
                            ),
                          ),

                              padding( 8,20, text(context, 'توقيت الاعلان', 14, black, fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(
                            top: 3.h, right: 2.w),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Radio<int>(
                                      value: 1,
                                      groupValue:
                                     _value4,
                                      activeColor:
                                      blue,
                                      onChanged:
                                          (value) {
                                        setState(() {
                                          _value4 =
                                              value;
                                          isValue1 =
                                          false;
                                        });
                                      }),
                                ),
                                text(
                                    context,
                                    "صباحا",
                                    14,
                                    ligthtBlack,
                                    family:
                                    'DINNextLTArabic'),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Radio<int>(
                                      value: 2,
                                      groupValue:
                                      _value4,
                                      activeColor:
                                      blue,
                                      onChanged:
                                          (value) {
                                        setState(() {
                                          _value4 =
                                              value;
                                          isValue1 =
                                          true;
                                        });
                                      }),
                                ),
                                text(
                                    context,
                                    "مساءا",
                                    14,
                                    ligthtBlack,
                                    family:
                                    'DINNextLTArabic'),
                              ],
                            ),
                          ],
                        ),
                      ),

                              //


                          paddingg(15, 15, 15, uploadImg(50, 45,text(context, 'فم ارفاق ملف الاعلان', 12, black),(){getFile(context);}),),
                          paddingg(15.w, 25.w, 2.h,text(context, warnimage ? 'الرجاء اضافة صورة': '', 13,red!,)),

                          paddingg(15, 15, 15,SizedBox(height: 45.h,child: InkWell(
                            child: gradientContainerNoborder(97, Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(scheduale, color: white,),
                                SizedBox(width: 15.w,),
                                text(context, 'تاريخ الاعلان', 15.sp, white, fontWeight: FontWeight.bold),
                              ],
                            )),onTap: () async { DateTime? endDate =
                              await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                    data: ThemeData.light().copyWith(
                                        colorScheme:
                                        const ColorScheme.light(primary: purple, onPrimary: white)),
                                    child: child!);}
                                    context:context,
                                  initialDate:
                                  current,
                                  firstDate:
                                  DateTime(2000),
                                  lastDate: DateTime(2100));

                          if (endDate == null)
                            return;
                          setState(() {
                            current= endDate;
                          });},
                          )),),
                          paddingg(15.w, 20.w, 2.h,text(context, datewarn2 ? 'الرجاء اختيار تاريخ النشر': '', 13,red!,)),

                          paddingg(0,0,12, CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: text(context,'عند طلب الاهداء، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', 10, black, fontWeight: FontWeight.bold,family:'Cairo'),
                            value: checkit,
                            subtitle: Text(warn2?'حتى تتمكن من الطلب  يجب الموافقة على الشروط والاحكام':'' ,style: TextStyle(color: red, fontSize: 12.sp),),
                            selectedTileColor: black,
                            onChanged: (value) {
                              setState(() {
                                setState(() {
                                  checkit = value!;
                                });
                              });
                            },),),
                          const SizedBox(height: 30,),
                          checkit?
                          padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context,'رفع الطلب', 15, white, (){
                            _formKey.currentState!.validate()? {
                              checkit && current.day != DateTime.now().day && image != null?{
                            addAdOrder()
                          } : setState((){ !checkit? warn2 = true: false;
                              current.day == DateTime.now().day? datewarn2 = true: false;
                              file == null? warnimage =true:false;}),

                            }:null;}))):

                          padding(15, 15, Container(width: getSize(context).width,
                              decoration: BoxDecoration( borderRadius: BorderRadius.circular(15.r),   color: grey,),
                              child: buttoms(context,'رفع الطلب', 15, white, (){})
                          ),),
                          const SizedBox(height: 30,),

                        ]),
                    ),),),
              ],
            ),
          ),),
    );


  }
buildCkechboxList(list) {

    return SizedBox(
      height: 150.h,
      child: Padding(
            padding: const EdgeInsets.all(2.0),

        ),
    );

  }
  Future<File?> getFile(context) async {

    PickedFile? pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final File f = File(pickedFile.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final String fileName = Path.basename(pickedFile.path);
    final String fileExtension = Path.extension(fileName);
    File newImage = await f.copy('$path/$fileName');
    if(fileExtension == ".png" || fileExtension == ".jpg"){
      file = newImage;
    }else{ ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
      content: Text(
          "امتداد الصورة المسموح به jpg, png",style: TextStyle(color: Colors.red)),
    ));}

    // }else{ ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(
    //   content: Text(
    //       "امتداد الصورة غير مسموح به",style: TextStyle(color: Colors.red)),
    // ));}
  }

  addAdOrder() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
    var stream;
    var length;
    var uri;
    var request;
    Map<String, String> headers;
    var response ;

     stream = await http.ByteStream(DelegatingStream.typed(file!.openRead()));
    // get file length
       length = await file!.length();

    // string to uri
    uri = Uri.parse("https://mobile.celebrityads.net/api/order/advertising/add");

     headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token2"
    };
    // create multipart request
    request = http.MultipartRequest("POST", uri);
   var multipartFile = new http.MultipartFile('file', stream, length,
        filename: Path.basename(file!.path));
    // multipart that takes file
    // multipartFile = new http.MultipartFile('file', file!.bytes.toList(), length,
    //     filename: file!.name),

    // listen for response
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields["celebrity_id"] = widget.id.toString();
    request.fields["date"]= current.toString();
    request.fields["description"]= description.text;
    request.fields["celebrity_promo_code_id"]= coupon.text;
    request.fields["ad_owner_id"]= _value.toString();
    request.fields["advertising_ad_type_id"]= _value3.toString();
    request.fields["ad_feature_id"]= _value2.toString();
    request.fields["ad_timing_id"]= _value4.toString();
    request.fields["advertising_ad_type_id"]= _value3.toString();

    response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });}


}