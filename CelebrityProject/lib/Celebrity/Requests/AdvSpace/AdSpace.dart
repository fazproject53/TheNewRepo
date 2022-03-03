import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:flutter/material.dart';
class AdSpace extends StatefulWidget {
 const  AdSpace({Key? key}) : super(key: key);

  @override
  State<AdSpace> createState() => _AdSpaceState();
}

class _AdSpaceState extends State<AdSpace> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, i) {
                return body();
              }),
    );
  }

  Widget body() {
    return container(
    180,double.infinity, 18,18, Colors.blue,
    Stack(),
    bottomLeft: 10,
    bottomRight: 10,
    topLeft: 10,
    topRight: 10,
    marginB: 15,
    blur: 5,
   marginT: 5
   
    );
  }
}
