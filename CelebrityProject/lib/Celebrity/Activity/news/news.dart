import 'package:celepraty/Celebrity/Activity/news/addNews.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class news extends StatefulWidget{
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {

   bool add= false;
   bool edit = false;

   int? theindex;
   String? title = "عنوان الخبر",des = "هذا وصف الخبر الذي قام بنشره المشهور.", date= 'وقت النشر: 12/10/2021';
    TextEditingController newstitle =new TextEditingController();
    TextEditingController newsdesc =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    edit?setState(() {
     title = newstitle.text;
     des = newsdesc.text;
    }): setState((){
     newstitle.text = title!;
     newsdesc.text = des!;
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: add? addNews() :SafeArea(
            child:SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    SizedBox(width: 30.w,),
                    gradientContainerNoborder2(150.w,45.h, buttoms(context, 'اضافة خبر', 14, white, (){setState(() {
                      add = true;
                    });})),

                  ],),
                paddingg(
                  10,
                  10,
                  20,
                  ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return paddingg(
                        8,
                        8,
                        5,
                        SizedBox(
                          height: edit&& theindex == index? 180.h: 150,
                          width: 300.w,
                          child: Card(
                            elevation: 5,
                            color: white,
                            child: paddingg(
                              0,
                              0,
                              8,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      paddingg(
                                      5,
                                        5,
                                        0,
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(2.0),
                                            child: Image.asset(
                                              'assets/image/celebrityimg.png',
                                              fit: BoxFit.fill,
                                              height: edit?150.h :130.h,
                                              width: 100.w,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(bottom: 5.h),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Container(
                                            width: 190.w,
                                            height: 40.h,
                                            child:edit && theindex == index?
                                            TextFormField( cursorColor: black,controller: newstitle,
                                              style: TextStyle(color: black, fontSize: 12, fontFamily: 'Cairo'),
                                              decoration: InputDecoration(fillColor: lightGrey,
                                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: pink)),
                                                  contentPadding: EdgeInsets.all(0.h)),)
                                                : text(
                                                context, title!, 14, black),
                                          ),
                                          SizedBox(
                                            height: edit&& theindex == index?8.h: 0.h,
                                          ),
                                          Container(
                                            width: 190.w,
                                            child:edit&& theindex == index?
                                            TextFormField( cursorColor: black,controller: newsdesc,
                                              maxLines: 3,
                                              style: TextStyle(color: black, fontSize: 12, fontFamily: 'Cairo'),
                                              decoration: InputDecoration(fillColor: lightGrey,
                                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: pink)),
                                                  contentPadding: EdgeInsets.all(0.h)), ): text(
                                                context, des!, 14, black),
                                          ),


                                        ],
                                      ),

                                    ],
                                  ),


                                  edit&& theindex == index? Padding(
                                        padding:  EdgeInsets.only(top:110.0.h, left: 15.w, right: 15.w),
                                    child: InkWell(
                                      child: Container(child: Icon(save,color: white, size: 18,),
                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),gradient:  const LinearGradient(
                                          begin: Alignment(0.7, 2.0),
                                          end: Alignment(-0.69, -1.0),
                                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                          stops: [0.0, 1.0],
                                        ) ),
                                        height: 28.h,
                                        width: 32.w,
                                      ),
                                      onTap: (){setState(() {
                                        edit = false;
                                      });},
                                    ),
                                  ):Padding(
                                    padding:  EdgeInsets.only(top:30.0.h, left: 10.w, right: 15.w),
                                    child: Column(children: [
                                      InkWell(
                                        child: Container(child: Icon(editDiscount,color: white, size: 18,),
                                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),gradient:  const LinearGradient(
                                            begin: Alignment(0.7, 2.0),
                                            end: Alignment(-0.69, -1.0),
                                            colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                            stops: [0.0, 1.0],
                                          ) ),
                                          height: 28.h,
                                          width: 32.w,
                                        ),
                                        onTap: (){setState(() {
                                          edit = true;
                                          theindex = index;
                                        });},
                                      ),
                                      SizedBox(height: 15.h,),

                                      Container(child: Icon(removeDiscount,color: white, size: 18,),
                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),gradient:  const LinearGradient(
                                          begin: Alignment(0.7, 2.0),
                                          end: Alignment(-0.69, -1.0),
                                          colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                          stops: [0.0, 1.0],
                                        ) ),
                                        height: 28.h,
                                        width: 32.w,
                                      ),

                                    ],),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],),
            )
        ),
      ),
    );
  }
}