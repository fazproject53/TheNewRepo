///import section

import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'introduction_screen.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  late Future<IntroData> getData;
  Future<IntroData> getIntroData() async {
    final data = await http
        .get(Uri.parse("http://mobile.celebrityads.net/api/sliders"));
    if (data.statusCode == 200) {
      return IntroData.fromJson(jsonDecode(data.body));
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  void initState() {
    setState(() {
      getData = getIntroData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<IntroData>(
        future: getData,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Stack(
          children: [
            ClipRRect(
              child:  Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
                        fit: BoxFit.cover)),
                  child: Padding(
                    padding:  EdgeInsets.only(top: 500.h,left: 20.w, right: 20.w),
                    child: ListTile(
                      title: text(context,"", 25, white,
                        fontWeight: FontWeight.bold, align: TextAlign.center),
                      subtitle: text(
                        context,
                        "",
                        13,
                        white, align: TextAlign.center),
                  ),
                ),
              ),

            )
          ],
        );
      }else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return Text('');}
      ),
    );
  }
}
//