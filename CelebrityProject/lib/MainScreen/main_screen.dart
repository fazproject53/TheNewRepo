import 'package:celepraty/Models/Methods/method.dart';
import 'package:flutter/material.dart';




class MainScreen2 extends StatelessWidget {
  const MainScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("الصفحة الرئيسية", context),
        body: const MainScreen2Main(),
      ),
    );
  }
}

class MainScreen2Main extends StatefulWidget {
  const MainScreen2Main({Key? key}) : super(key: key);

  @override
  _MainScreen2MainState createState() => _MainScreen2MainState();
}

class _MainScreen2MainState extends State<MainScreen2Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

