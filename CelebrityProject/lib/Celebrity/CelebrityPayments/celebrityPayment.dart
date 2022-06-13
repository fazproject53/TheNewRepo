
import 'package:flutter/material.dart';

class CelebrityPayments extends StatefulWidget {
  const CelebrityPayments({Key? key}) : super(key: key);

  @override
  _CelebrityPaymentsState createState() => _CelebrityPaymentsState();
}

class _CelebrityPaymentsState extends State<CelebrityPayments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('قائمة الدفع'),
      ),
    );
  }
}
