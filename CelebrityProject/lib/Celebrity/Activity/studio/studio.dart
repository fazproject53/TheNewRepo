
import 'package:celepraty/Celebrity/Activity/ExpandableFab%20.dart';
import 'package:celepraty/Celebrity/Activity/studio/addVideo.dart';
import 'package:celepraty/Celebrity/Activity/studio/addphoto.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Studio extends StatefulWidget{
  _StudioState createState() => _StudioState();
}

class _StudioState extends State<Studio> {
  bool addp = false;
  bool addv= false;
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
       floatingActionButton:addv || addp ? null:ExpandableFab(
         distance: 80.0,
         children: [
           ActionButton(
             onPressed: () => {setState(() {
               addv= true;
             })},
             icon:  Icon(vieduoIcon,color: white,),
             color: pink,
           ),
           ActionButton(
             onPressed: () => {setState(() {
               addp= true;
             })},
             icon:  Icon(imageIcon,color: white,),
             color: pink,
           ),
         ],
       ),

        body: addp? addphoto(): addv? addVideo():
        SingleChildScrollView(
          child: Column(
            children: [
              paddingg(
                10,
                10,
                0,
                Container(
                  height:getSize(context).height,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return paddingg(
                        8,
                        8,
                        5,
                        SizedBox(
                          height: 140.h,
                          width: 260.w,
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
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          Container(
                                            width: 190.w,
                                            child: text(
                                                context, 'وصف لصورة او فيديو تم نشرها بواسطة المشهور.', 14, black),
                                          ),
                                          SizedBox(height: 10.h,),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Padding(
                                    padding:  EdgeInsets.only(bottom: 20.h, left: 15.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30.h,),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),



              ],),
        ),
      ),
    );
  }

}

