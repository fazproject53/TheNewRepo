import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/Methods/method.dart';
import '../../Models/Variables/Variables.dart';

class ImageData extends StatefulWidget {
  final String? image;
  const ImageData({Key? key, this.image}) : super(key: key);

  @override
  _ImageDataState createState() => _ImageDataState();
}

class _ImageDataState extends State<ImageData> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: drowAppBar("", context),
            //backgroundColor: black.withOpacity(0.80),
            body: Container(
              // color: red,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                  widget.image!,
                ),
                fit: BoxFit.contain,
              )),
            )));
  }
}
