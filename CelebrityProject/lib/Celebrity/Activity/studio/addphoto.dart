import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:celepraty/Celebrity/Activity/studio/studio.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as Path;
import '../activity_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';


class addphoto extends StatefulWidget{

  _addphotoState createState() => _addphotoState();
}

class _addphotoState extends State<addphoto> {

  final _formKey = GlobalKey<FormState>();
 TextEditingController controlphototitle = new TextEditingController();
   TextEditingController controlphotodesc = new TextEditingController();

  File? studioimage;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Form(        key: _formKey,

                      child: paddingg(12, 12, 5, Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اضافة صورة جديدة', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

                            SizedBox(height: 20.h,),

                            paddingg(15, 15, 12,textFieldNoIcon(context, 'عنوان الصورة', 14, false, controlphototitle,(String? value) {if (
                            value == null || value.isEmpty) {
                              return 'حقل اجباري';}},false),),
                            paddingg(15, 15, 12,textFieldDesc(context, 'وصف الصورة', 14, false, controlphotodesc,(String? value) {if (
                            value == null || value.isEmpty) {
                              return 'حقل اجباري';}}),),


                            SizedBox(height: 20.h),
                            paddingg(15, 15, 12, uploadImg(200, 54,text(context, 'قم برفع صورة ', 12, black),(){getPhoto(context);}),),

                            SizedBox(height: 20.h),
                            padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'اضافة ', 15, white, (){
                              if(_formKey.currentState!.validate()){
                                addPhoto().whenComplete(() => goTopageReplacement(context, ActivityScreen()));

                              }
                              })),),
                            const SizedBox(height: 30,),
                          ]),
                      ),

                    ))
            )
        ),
      ),
    );
  }

   addPhoto() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';


    var stream = new http.ByteStream(DelegatingStream.typed(studioimage!.openRead()));
    // get file length
    var length = await studioimage!.length();

    // string to uri
    var uri =
    Uri.parse("https://mobile.celebrityads.net/api/celebrity/studio/add");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token2"
    };
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(studioimage!.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields["title"] = controlphototitle.text;
    request.fields["description"] = controlphotodesc.text;
    request.fields["type"] = "image";
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

  }

  Future<File?> getPhoto(context) async {
    PickedFile? pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final File file = File(pickedFile.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final String fileName = Path.basename(pickedFile.path);
    final String fileExtension = Path.extension(fileName);
    File newImage = await file.copy('$path/$fileName');
    setState(() {
      if(fileExtension == ".png" || fileExtension == ".jpg"){
        studioimage = newImage;
      }else{ ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text(
            "امتداد الصورة المسموح به jpg, png",style: TextStyle(color: Colors.red)),
      ));}

    });
  }
}