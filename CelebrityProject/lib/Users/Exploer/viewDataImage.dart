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
      child:  Scaffold(
        backgroundColor: black.withOpacity(0.80),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, right: 20.w),
              child: Row(
                children: [
                  ///back icon to the main screen
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: white,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: getSize(context).height/9),
                          height: 400.h,
                          child: widget.image == null ? Text('No Photo To Show') :  Image.network(widget.image!)),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ), ),
    );
  }
}
