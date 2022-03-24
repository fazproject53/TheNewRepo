///import section
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/intro2.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding:  EdgeInsets.only(top: 500.h,left: 20.w, right: 20.w),
              child: ListTile(
                title: text(context, 'نجمك المفضل عندنا', 25, white,
                    fontWeight: FontWeight.bold, align: TextAlign.center),
                subtitle: text(
                    context,
                    'يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو, يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو',
                    13,
                    white, align: TextAlign.center),
              ),
            ),
          )
        ],
      ),
    );
  }
}
