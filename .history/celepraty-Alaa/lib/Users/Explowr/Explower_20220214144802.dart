import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Explower extends StatefulWidget {
  const Explower({Key? key}) : super(key: key);

  @override
  State<Explower> createState() => _ExplowerState();
}

class _ExplowerState extends State<Explower> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: drowAppBar("اكسبلور"),
          body: Padding(
            padding:  EdgeInsets.all(12.h),
            child:Column(
              children: const [
               text(context, "key", 15, black),
                Expanded(flex: 6,child:Placeholder()),
              ],
            ),
          )),
    );
  
  }

  Widget viewCard(){
    return Card(
      elevation: 10,
      color: black,
      
      );
   }
}
