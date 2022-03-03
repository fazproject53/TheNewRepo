import 'dart:io';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class chatScreen extends StatefulWidget{
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

  List<Widget>? listwidget;
  File? imagee;

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    listwidget= [  container('بخير الحمد لله'), container('مرحبا'), containerUser('ليجسي كيف حالك ؟'), containerUser('مرحبا'),];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drawAppBar( Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [ text(context, 'مروان بابلو', 15, white),SizedBox(width: 10.w,),   CircleAvatar( backgroundColor: white,//backgroundImage: Image.asset('assets/image/featured.png').image,
          )],) , context, color: purple),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Expanded(
              child: ListView(
                reverse: true,
                children: listwidget!,
              ),
              ),

            Container(
              decoration:  const BoxDecoration(  color: fillWhite ,border: Border(top: BorderSide(color: purple , width: 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        SizedBox(width: 20.w,),
                        GestureDetector(child: Icon(voiceIcon, color: isPressed? purple: grey, size: isPressed? 50: 30,), onLongPress:() {
                          setState(() {
                            isPressed= true;
                          });
                        },
                          onLongPressUp: () {
                            setState(() {
                              isPressed= false;
                            });
                          },),

                        SizedBox(width: 10.w,),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          child: InkWell(onTap: (){}, child: GradientIcon(send, 30, const LinearGradient(
                            begin: Alignment(0.7, 2.0),
                            end: Alignment(-0.69, -1.0),
                            colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                            stops: [0.0, 1.0],
                          ),),),
                        ),


                      ],
                    ),
                  ),


                Expanded(
                  child: TextField(
                    onChanged: (value){},
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                        hintText: 'اكتب هنا .....',

                    ),),
                ),
                  InkWell(child: Icon(image, color: grey,), onTap: (){ pickImage(imagee);},),
                  SizedBox(width: 20.w,)
              ],),
            )
          ],),
        ),
      ),
    );
  }

  Widget container(text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45.h,
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 5),
          decoration: BoxDecoration(color: purple, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: white),),
          ),
        ),
      ],
    );
  }

  Widget containerUser(text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 45.h,
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 2),
          decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: white),),
          ),
        ),
      ],
    );
  }
}