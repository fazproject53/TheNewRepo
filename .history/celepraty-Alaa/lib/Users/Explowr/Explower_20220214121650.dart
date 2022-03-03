import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:flutter/material.dart';

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
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //عدد العناصر في كل صف
                  crossAxisSpacing: 8, // المسافات الراسية
                  childAspectRatio: 0.70, //حجم العناصر
                  mainAxisSpacing: 12 //المسافات الافقية

                  ),
              itemBuilder: (context, i) {
                return Card(color: Colors.black,);
              })),
    );
  
  }
}
