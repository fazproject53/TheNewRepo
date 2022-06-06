import 'dart:convert';
import 'dart:io';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

import 'AdvFormResponse.dart';

class advForm extends StatefulWidget{
  final String? id,image, name;
  const advForm({Key? key,  this.id, this.image, this.name}) : super(key: key);
  _advFormState createState() => _advFormState();
}

class _advFormState extends State<advForm>{
  static var resp = new Responsee();
  Future<Platform>? platforms;
  int? _value = 1;
  bool isValue1 = false;
  int? _value2 = 1;
  int? _value3 = 1;
  int? _value4 = 1;

  var platformlist = [];

  String platform = 'اختر منصة العرض';

  List<DropdownMenuItem<Object?>> _dropdownTestItem = [];

  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
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
  void initState() {
    platforms = fetchPlatform();
    _dropdownTestItem = buildDropdownTestItems(platformlist);
    super.initState();
  }

  Future<Platform> fetchPlatform() async {
    final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/platforms'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return Platform.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: drowAppBar('طلب اعلان', context),
        body:  SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                    alignment: Alignment.bottomRight,
                    children: [ Container(height: 365.h,
                        width: 1000.w,
                        child: Image.network(widget.image!, color: Colors.black45, colorBlendMode:BlendMode.darken,fit: BoxFit.cover,)),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(  'اطلب اعلان\n' + 'شخصي من ' + widget.name! + ' الان',
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
                          FutureBuilder(
                              future: platforms,
                              builder: ((context, AsyncSnapshot<Platform> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return  paddingg(15, 15, 12,
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
                                        platform,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      value: _selectedTest,
                                      items: _dropdownTestItem,
                                      onChanged: onChangeDropdownTests,
                                    ),
                                  );
                                } else if (snapshot.connectionState == ConnectionState.active ||
                                    snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text(snapshot.error.toString()));
                                    //---------------------------------------------------------------------------
                                  } else if (snapshot.hasData) {
                                    _dropdownTestItem.isEmpty?{
                                      platformlist.add({'no': 0, 'keyword': 'اختر منصة الاعلان'}),
                                      for(int i =0; i< snapshot.data!.data!.length; i++) {
                                        platformlist.add({'no': snapshot.data!.data![i].id!, 'keyword': '${snapshot.data!.data![i].name!}'}),
                                      },
                                      _dropdownTestItem = buildDropdownTestItems(platformlist),
                                    } : null;

                                    return paddingg(15, 15, 12,
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
                                          platform,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        value: _selectedTest,
                                        items: _dropdownTestItem,
                                        onChanged: onChangeDropdownTests,
                                      ),
                                    );
                                  } else {
                                    return const Center(child: Text('لايوجد لينك لعرضهم حاليا'));
                                  }
                                } else {
                                  return Center(
                                      child: Text('State: ${snapshot.connectionState}'));
                                }
                              })),

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
                            addAdOrder().then((value) => {
                              ScaffoldMessenger.of(
                                context)
                                .showSnackBar(
                                 SnackBar(content: Text(resp.message!.ar!),
                                ))})
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

  Future<Responsee> addAdOrder() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
    var stream;
    var length;
    var uri;
    var request;
    Map<String, String> headers;
    var response;
    var body;
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
    request.fields["celebrity_id"] =widget.id.toString();
    request.fields["date"]= current.toString();
    request.fields[" platform_id"]= platformlist.indexOf(_selectedTest).toString();
    request.fields["description"]= description.text;
    request.fields["celebrity_promo_code_id"]= coupon.text;
    request.fields["ad_owner_id"]= _value.toString();
    request.fields["ad_feature_id"]= _value2.toString();
    request.fields["ad_timing_id"]= _value4.toString();
    request.fields["advertising_ad_type_id"]= _value3.toString();
    request.fields["advertising_name"] = '';
    request.fields["advertising_link"] = '';
    response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      setState(() {
        resp = Responsee.fromJson(jsonDecode(value));

      });
    });
    return resp;
  }


}


class Platform {
  bool? success;
  List<Data>? data;
  Message? message;

  Platform({this.success, this.data, this.message});

  Platform.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? nameEn;

  Data({this.id, this.name, this.nameEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}