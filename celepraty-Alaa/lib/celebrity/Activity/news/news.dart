import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:celepraty/celebrity/Activity/news/addNews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class news extends StatefulWidget{
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {

   bool add= false;
   bool edit = false;

   String? title = "عنوان الخبر",des = "هذا وصف الخبر الذي قام بنشره المشهور.", date= 'وقت النشر: 12/10/2021';
    TextEditingController newstitle =new TextEditingController();
    TextEditingController newsdesc =new TextEditingController();
    TextEditingController newsdate =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    edit?setState(() {
     title = newstitle.text;
     des = newsdesc.text;
     date = newsdate.text;
    }): setState((){
     newstitle.text = title!;
     newsdesc.text = des!;
     newsdate.text = date!;
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
                          height: edit? 200.h: 150,
                          width: 300.w,
                          child: Card(
                            elevation: 10,
                            color: white,
                            child: paddingg(
                              0,
                              0,
                              8,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  paddingg(
                                  0,
                                    5,
                                    0,
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2.0),
                                        child: Image.asset(
                                          'assets/image/celebrityimg.png',
                                          fit: BoxFit.fill,
                                          height: 130.h,
                                          width: 100.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Container(
                                        width: 190.w,
                                        height: 30.h,
                                        child:edit?
                                           TextFormField( controller: newstitle,
                                            style: TextStyle(color: black, fontSize: 12, fontFamily: 'Cairo'),
                                          decoration: InputDecoration(fillColor: lightGrey, border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                          contentPadding: EdgeInsets.all(0.h)),)
                                        : text(
                                            context, title!, 14, black),
                                      ),
                                      SizedBox(
                                        height: edit?5.h: 0.h,
                                      ),
                                      Container(
                                        width: 190.w,
                                        child:edit?
                                        TextFormField( controller: newsdesc,
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontFamily: 'Cairo'),
                                            decoration: InputDecoration(fillColor: lightGrey, border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                                contentPadding: EdgeInsets.all(0.h)), ): text(
                                            context, des!, 14, black),
                                      ),


                                      SizedBox(height: 5.h,),
                                      Container(
                                        width: 190.w,
                                        child:edit? TextFormField( controller: newsdate,
                                          style: TextStyle(color: black, fontSize: 12, fontFamily: 'Cairo'),
                                          decoration: InputDecoration(fillColor: lightGrey, border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                                              contentPadding: EdgeInsets.all(0.h)), ): text(
                                            context, date!, 14, black),
                                      ),

                                    ],
                                  ),

                                  Padding(
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