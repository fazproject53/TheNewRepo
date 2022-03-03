
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Studio extends StatefulWidget{
  _StudioState createState() => _StudioState();
}

class _StudioState extends State<Studio> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
         child:SingleChildScrollView(
           child: Column(children: [
             SizedBox(height: 30.h,),
             Row(
               children: [
                 SizedBox(width: 30.w,),
               gradientContainerNoborder2(150.w,45.h, buttoms(context, 'اضافة صورة', 14, white, (){})),
                 SizedBox(width: 20.w,),
               gradientContainerNoborder2(150.w, 45.h, buttoms(context, 'اضافة فيديو', 14, white, (){}))
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
                       height: 150.h,
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
                                 5,
                                 10,
                                 0,
                                 Container(
                                   alignment: Alignment.centerRight,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(2.0),
                                     child: Image.asset(
                                       'assets/image/celebrityimg.png',
                                       fit: BoxFit.fill,
                                       height: 100.h,
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
                                     height: 20.h,
                                   ),
                                   Container(
                                     width: 200.w,
                                     child: text(
                                         context, 'وصف لصورة او فيديو تم نشرها بواسطة المشهور.', 14, black),
                                   ),
                                   SizedBox(height: 10.h,),
                                   Row(
                                     children: [
                                       text(context, 'وقت النشر: 12/10/2021', 14,
                                           black),
                                       SizedBox(width: 50.w,),
                                       Container(child: Icon(removeDiscount,color: white, size: 18,),
                                           decoration: BoxDecoration( borderRadius: BorderRadius.circular(50),gradient:  const LinearGradient(
                                             begin: Alignment(0.7, 2.0),
                                             end: Alignment(-0.69, -1.0),
                                             colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                             stops: [0.0, 1.0],
                                           ) ),
                                       height: 28.h,
                                       width: 32.w,
                                       )
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 10,
                                   ),
                                 ],
                               ),
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