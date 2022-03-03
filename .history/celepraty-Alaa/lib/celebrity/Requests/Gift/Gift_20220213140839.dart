import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'GiftDetials.dart';
class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  @override
 Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: (){
               goTopagepush(context, GiftDetials(i:i));
              },
              child: body(i));
          }),
    );
  }

  Widget body(int i) {
    return container(
        200,
        double.infinity,
        18,
        18,
        Colors.white,
        Column(
          children: [
//image-----------------------------------------
            Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.h),
                      topRight: Radius.circular(10.h),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          giftImage[i],
                        ),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black45, BlendMode.darken)),
                  ),
// مناسبه الاهداء-----------------------------------------
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   
                      Align(
                     
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                            child:text(context, "اهداء ل"+giftType[i], 18, white,fontWeight:FontWeight.bold,)
                        )
                        ),
                       
//date and icon-------------------------------------------------------------

                    //  Row(
                      
                    //   children: [
                      
                    //      Align(
                    //         alignment: Alignment.bottomLeft,
                    //         child:text(context, "12/12/2022", 15, white,fontWeight:FontWeight.bold,)
                    //         ),
                    //     Align(
                    //         alignment: Alignment.bottomLeft,
                    //         child: Icon(clander,color:deepblue) ),
                    //          SizedBox(width:10.w),
                    //   ],
                    //   )
                    ],
                  )),
            ),

//detaiels-----------------------------------------

   Expanded(flex: 1, child: 
   Row(
   children: [
//type-------------------------------------------------
     Expanded(flex: 1,child:Column(
   children: [
     Expanded(flex: 1, child:text(context, "من", 12, black,)
),
     Expanded(flex: 1, child:text(context, "محمد علي", 12, pink,fontWeight:FontWeight.bold)
   )],
     )),
     divider(),
//owner-------------------------------------------------

   Expanded(flex: 1,child:Column(
   children: [
     Expanded(flex: 1, child:text(context, "الى", 12, black,)
),
     Expanded(flex: 1, child:text(context, "احمد عمر", 12, pink,fontWeight:FontWeight.bold)
   )],
     )),      divider(),
//time-------------------------------------------------

   Expanded(flex: 1,child:Column(
   children: [
     Expanded(flex: 1, child:text(context, "التاريخ", 12, black,)
),
     Expanded(flex: 1, child:text(context, "12/12/2021", 12, pink,fontWeight:FontWeight.bold)
   )],
     )),   ],
   ))
         
         
         
         
         
         
         
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        marginB: 15,
        blur: 5,
        marginT: 5);
  }
}
