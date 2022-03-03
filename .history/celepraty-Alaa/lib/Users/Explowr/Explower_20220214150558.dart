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
              padding: EdgeInsets.all(12.h),
              child: Column(
                children: [
//icon and text-----------------------------------------------------
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        text(context, "اكسبلور المشاهير", 18, black),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            filter,
                            size: 34.sp,
                          ),
                        )
                      ])),
//view data-----------------------------------------------------

                  Expanded(
                    flex: 6,
                    child: GridView.builder(
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //عدد العناصر في كل صف
                            crossAxisSpacing: 13.h, // المسافات الراسية
                            childAspectRatio: 0.70, //حجم العناصر
                            mainAxisSpacing: 13.w //المسافات الافقية

                            ),
                        itemBuilder: (context, i) {
                          return viewCard();
                        }),
                  )
                ],
              ))),
    );
  }

  Widget viewCard() {
    return Card(
      elevation: 10,
      color: black,
      child:Stack(children: [
        Al
      ],)
    );
  }
}
