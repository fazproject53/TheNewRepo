import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../activity_screen.dart';

class addNews extends StatefulWidget{

  _addNewsState createState() => _addNewsState();
}

class _addNewsState extends State<addNews> {

  final _formKey = GlobalKey<FormState>();
   TextEditingController controlnewstitle = new TextEditingController();
   TextEditingController controlnewsdesc = new TextEditingController();

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
                          padding(10, 12, Container( alignment : Alignment.topRight,child:  Text(' اضافة خبر جديد', style: TextStyle(fontSize: 18.sp, color: textBlack , fontFamily: 'Cairo'), )),),

                          SizedBox(height: 20.h,),

                          paddingg(15, 15, 12,textFieldNoIcon(context, 'عنوان الخبر', 14, false, controlnewstitle,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;},false),),
                          paddingg(15, 15, 12,textFieldDesc(context, 'وصف الخبر', 14, false, controlnewsdesc,(String? value) {if (value == null || value.isEmpty) {
                            return 'Please enter some text';} return null;}),),

                          SizedBox(height: 20.h),
                          padding(15, 15, gradientContainerNoborder(getSize(context).width,  buttoms(context, 'اضافة الخبر', 15, white, (){
                            addNews();
                            goTopageReplacement(context, ActivityScreen()) ;})),),
                          const SizedBox(height: 30,),
                        ]),
                    ),

                  ))
            )
        ),
      ),
    );
  }
  Future<http.Response> addNews() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ'
        '6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/celebrity/news/add',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        "title" : controlnewstitle.text,
        "description" : controlnewsdesc.text
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print(response.body);
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
}