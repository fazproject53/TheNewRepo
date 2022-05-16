import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';

class advArea extends StatefulWidget{
  _advAreaState createState() => _advAreaState();
}

class _advAreaState extends State<advArea>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController link = new TextEditingController();

  File? image;
   DateTime dateTime = DateTime.now();
  bool datewarn2= false;
  bool check2 = false;
  bool warn2= false;
  bool warnimage= false;

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar('مساحة اعلانية', context),
          body: SingleChildScrollView(
          child: Container(
          child: Form(
          key: _formKey,
          child: paddingg(12, 12, 5, Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          SizedBox(height: 120.h,),
            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اطلب مساحتك الاعلانية', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

            SizedBox(height: 20.h,),

            paddingg(15, 15, 12,textFieldNoIcon(context, 'رابط صفحة المعلن', 14, false, link,(String? value) {if (value == null || value.isEmpty) {
              return 'حقل اجباري';}else{
              bool _validURL = Uri.parse(value).isAbsolute;
             return  _validURL? null: 'رابط الفحة غير صحيح';
            }},false),),



             SizedBox(height: 20.h),
            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع الصورة التي تريد وضعها بالاعلان', 12, black),(){getImage();}),),
            paddingg(15.w, 25.w, 5.h,Text(warnimage? 'الرجاء اضافة صورة': '', style: TextStyle(color: red),)),
            SizedBox(height: 10.h),
            InkWell(
              child: padding(0.w,15.w, Row(children: [
                  GradientIcon(scheduale, 30, const LinearGradient(
                    begin: Alignment(0.7, 2.0),
                    end: Alignment(-0.69, -1.0),
                    colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                    stops: [0.0, 1.0],
                  ),),
                 SizedBox(width: 10.w,),
                  text(context, 'تاريخ الاعلان', 12, black)
                ],),
              ),
              onTap: () async { DateTime? endDate =
                  await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                        data: ThemeData.light().copyWith(
                            colorScheme:
                            const ColorScheme.light(primary: purple, onPrimary: white)),
                        child: child!);}
                  context:
                  context,
                  initialDate:
                  dateTime,
                  firstDate:
                  DateTime(
                      2000),
                  lastDate:
                  DateTime(
                      2100));
              if (endDate == null)
                return;
              setState(() {
                dateTime= endDate;
              });},
            ),

            paddingg(15.w, 20.w, 0.h,Text(datewarn2? 'الرجاء اختيار تاريخ الاهداء': '', style: TextStyle(color: red),)),

            paddingg(0,0,3.h, CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: text(context,'عند طلب الاهداء، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', 10, black, fontWeight: FontWeight.bold,family:'Cairo'),
              value: check2,
              selectedTileColor: warn2 == true? red: black,
              subtitle: Text(warn2 == true?'حتى تتمكن من طلب الاهداء يجب الموافقة على الشروط والاحكام':'' ,style: TextStyle(color: red),),
              onChanged: (value) {
                setState(() {
                  setState(() {
                    check2 = value!;
                  });
                });
              },)

              ,),
             SizedBox(height: 30.h,),
            padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'رفع الطلب', 15, white, (){
              _formKey.currentState!.validate()? {
                check2 && dateTime.day != DateTime.now().day && image != null?{
                  addAdAreaOrder()
                } : setState((){ !check2? warn2 = true: false;
                dateTime.day == DateTime.now().day? datewarn2 = true: false;
                image == null? warnimage =true:false;}),

              }: null;
            })),),

          ]),
          ),

          )))),
    );}

 addAdAreaOrder() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
    var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
    // get file length
    var length = await image!.length();

    // string to uri
    var uri = Uri.parse("https://mobile.celebrityads.net/api/order/ad-space/add");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token2"
    };
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: Path.basename(image!.path));

    // listen for response
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields["celebrity_id"] = 6.toString();
    request.fields["date"]=dateTime.toString();
    request.fields["link"]= link.text;

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    }

  Future<File?> getImage() async {
    PickedFile? pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final File file = File(pickedFile.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final String fileName = Path.basename(pickedFile.path);
// final String fileExtension = extension(image.path);
    File newImage = await file.copy('$path/$fileName');
    setState(() {
      image = newImage;
    });
  }

}


