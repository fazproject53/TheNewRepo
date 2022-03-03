import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestMainPage extends StatefulWidget {
  RequestMainPage({Key? key}) : super(key: key);

  @override
  State<RequestMainPage> createState() => _RequestMainPageState();
}

class _RequestMainPageState extends State<RequestMainPage> {
  @override
  Widget build(BuildContext context) {
    return 
   ?extDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar(requestBar),
        body: padding(33, 33, Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  [
            SizedBox(height: 66.h,),
           const Expanded(
             flex: 1,
             child:  Placeholder(),
             ),
             const Expanded(
             flex: 1,
             child:  Placeholder(),
             ),
             const Expanded(
             flex: 4,
             child:  Placeholder(),
             ),
            SizedBox(height: 10.h,),
          ],
        )),
      ),
    );
  }
}