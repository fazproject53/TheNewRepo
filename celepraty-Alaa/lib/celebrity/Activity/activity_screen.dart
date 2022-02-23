import 'package:celepraty/Models/Methods/method.dart';
import 'package:flutter/material.dart';




class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarNoIcon("التفاعلات"),
        body: const ActivityScreenMain(),
      ),
    );
  }
}
class ActivityScreenMain extends StatefulWidget {
  const ActivityScreenMain({Key? key}) : super(key: key);

  @override
  _ActivityScreenMainState createState() => _ActivityScreenMainState();
}

class _ActivityScreenMainState extends State<ActivityScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
