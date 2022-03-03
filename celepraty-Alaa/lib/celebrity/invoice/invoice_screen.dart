
import 'dart:io';

import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:celepraty/celebrity/invoice/ivoice_info_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class invoiceScreen extends StatefulWidget{
  _invoiceScreenState createState() => _invoiceScreenState();
}

class _invoiceScreenState extends State<invoiceScreen> {
  List<String> imagePaths = [];
  final imagePicker = ImagePicker();
   final file = File('example.pdf');
  //  final pdf = pw.Document();
    DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: drowAppBar( 'الفوترة',  context),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30.h,),
                    text(context, 'الطلبات المالية السابقة', 17, black),
                    SizedBox(height: 30.h,),
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount: invoiceList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                              child: ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.receipt_long, color: black.withOpacity(0.80), size: 27,),
                                        SizedBox(width: 20.w),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              text(context, invoiceList[index].userName, 16, black),


                                              text(context, invoiceList[index].price.toInt().toString() + " ر.س", 15, green),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    text(context, invoiceList[index].date.toString().substring(0,11), 12, grey!),
                                  ],
                                ),
                                  children: [
                                    Container(
                                        margin:
                                        EdgeInsets.only(top: 10.h),
                                        height: 70.h,
                                        decoration: BoxDecoration(color: fillWhite, border: Border(top: BorderSide(color: lightGrey.withOpacity(0.10))),) ,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(right: 15.0.w),
                                              child: text(context, 'التفاصيل', 12, grey!),
                                            ),
                                            Container(child: text(context, invoiceList[index].desc, 14,  black),
                                            width: 200.w,
                                            margin: EdgeInsets.only(right: 10.w),),
                                           Padding(
                                             padding: EdgeInsets.only(left: 10.w),
                                               child: Row(children:[
                                                 InkWell(child: Icon(Icons.info_outlined, size: 20,), onTap: (){
                                                   showBottomSheettInvoice(context, invoice(index));
                                                 },),
                                                 SizedBox(width: 15.w,),
                                                 InkWell(
                                                   child: GradientIcon(Icons.share, 20, const LinearGradient(
                                                     begin: Alignment(0.7, 2.0),
                                                     end: Alignment(-0.69, -1.0),
                                                     colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                                                     stops: [0.0, 1.0],
                                                   ),),
                                                   onTap: ()  {
                                                     // final pickedFile = await imagePicker.pickImage(
                                                     //   source: ImageSource.gallery,
                                                     // );
                                                     // if (pickedFile != null) {
                                                     //   setState(() {
                                                     //     imagePaths.add(pickedFile.path);
                                                     //   });
                                                     // }
                                                     // Future<void> main() async {
                                                     //   final pdf = pw.Document();
                                                     //
                                                     //   pdf.addPage(
                                                     //     pw.Page(
                                                     //       build: (pw.Context context) => pw.Center(
                                                     //         child: pw.Text('Hello World!'),
                                                     //       ),
                                                     //     ),
                                                     //   );
                                                     //
                                                     //   final file = File('example.pdf');
                                                     //   await file.writeAsBytes(await pdf.save());
                                                     //   imagePaths.add(file);
                                                     // }
                                                     imagePaths.add(file.path);
                                                     Share.share(imagePaths[0]);
                                                   },
                                                 ),

                                            ]),
                                    ),
                                          ],
                              ))]
                              ));
                        },),
                  ],
                ),
              ),

            )
        ),
    );
  }
Widget invoice(index){
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(width: 450.w, height: 60.h, decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),
                        topRight: Radius.circular(20) ), color: lightGrey.withOpacity(0.30)),),
                    Container(width: 60.w, height: 5.h,
                      decoration: BoxDecoration(color: grey ,borderRadius: BorderRadius.all( Radius.circular(50))),),
                  ],
                ),
                onTap: (){Navigator.pop(context);},
              ),

              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image .asset('assets/image/logo.png', height: 100.h, width: 100.w,),
                  SizedBox(width: 5.w,),
                  GradientText(
                    'منصة المشاهير',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold
                    ),
                    colors: const [
                      Color(0xff0ab3d0), Color(0xffe468ca)
                    ],
                  ),
                ],
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Directionality(textDirection: TextDirection.rtl, child: text(context, date.toString().substring(0,16) + ' PM', 15, grey!)),
                    text(context, 'فاتورة ضريبية', 18, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                  ],),
                margin: EdgeInsets.only(top: 15.h, left:15.w, right: 15.w),
              ),

              padding(15,15, Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    text(context, '320004576#', 18, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                    SizedBox(height: 15.h,),
                    text(context, 'رقم الطلب:  320004576', 15, black),
                    text(context, 'رقم الفاتورة:  0200000', 15, black),
                    Divider(color: black,)
                  ],
                ),
              ),
              padding(15,15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                text(context, ': مصدرة من ', 18, blue, fontWeight: FontWeight.bold),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: text(context, "منصة المشاهير", 15, black), margin: EdgeInsets.only(left: 40.w)),
                  text(context, ': الموقع الالكتروني', 15, black.withOpacity(0.75), fontWeight: FontWeight.bold ),
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: text(context, "لا يوجد", 15, black), margin: EdgeInsets.only(left: 80.w),),
                  text(context, ': الرقم الضريبي', 15, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: text(context, "+966567427796", 15, black),margin: EdgeInsets.only(left: 30.w)),
                  text(context, ': الهاتف', 15, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                ],),
                Divider(color: black,)
              ],)
              ),

              padding(15,15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      text(context, ': مصدرة الى ', 18, pink, fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: text(context, 'السعودية', 15, black),margin: EdgeInsets.only(left: 75.w)),
                          Container(child: text(context, "Alaa bag", 15, black.withOpacity(0.75), fontWeight: FontWeight.bold )),

                        ],),
                      Container(child: text(context, "+966567427796", 15, black),margin: EdgeInsets.only(left: 30.w), alignment: Alignment.bottomLeft,),
                      Divider(color: black,)
                    ],)
              ),
              padding(15,15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      text(context, 'تفاصيل الدفع', 17, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: text(context, "112 ر.س", 15, blue, fontWeight: FontWeight.bold), margin: EdgeInsets.only(left: 75.w)),
                          text(context, ': المبلغ', 17, blue, fontWeight: FontWeight.bold ),
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: text(context, "مصرف الراجحي", 15, black), margin: EdgeInsets.only(left: 50.w),),
                          Container(child: text(context, ':طريقة الدفع', 15, black.withOpacity(0.75), fontWeight: FontWeight.bold)),
                        ],),
                      SizedBox(height: 10.h,)
                    ],)
              ),
              Container(
                color: grey!.withOpacity(0.40),
                height: 45.h,
                margin: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Row(
                    children: [
                      SizedBox(width: 40.w,),
                      text(context, 'المجموع', 15, black),
                      SizedBox(width: 20.w,),
                      text(context, 'السعر', 15, black),
                      SizedBox(width: 20.w,),

                    ],
                  ),
                    Row(
                      children: [
                        text(context, 'المنتج', 15, black),
                        SizedBox(width: 10.w,),
                      ],
                    ),
                ],),
              ),

               Directionality(
                 textDirection: TextDirection.rtl,
                 child: Column(
                    children: [
                     SizedBox(height: 20.h,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                        Row(
                          children: [
                            SizedBox(width: 20.w,),
                            Container(
                                child: text(context, 'طلب اهداء/ صورة بمناسبة\n عيد ميلاد', 15, black),),
                            // SizedBox(width: 10.w,),
                            // Image.asset('assets/image/logo.png', height: 50.h, width: 50.w,),

                          ],
                        ),
                          Row(
                            children: [
                              SizedBox(width: 30.w,),
                              text(context, ' 89 ر.س', 15, black),
                              SizedBox(width: 30.w,),
                              text(context, '89 ر.س', 15, black),
                              SizedBox(width: 50.w,),
                            ],
                          ),
                      ],),
                      SizedBox(height: 10.h,),
                      Divider(color: black, thickness: 1.5,),
                      SizedBox(height: 10.h,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                        Row(
                          children: [
                            SizedBox(width: 20.w,),
                            text(context, 'مجموع السلة', 15, black),
                          ],
                        ),
                          Row(
                            children: [
                              text(context, '89 ر.س', 15, black),
                              SizedBox(width: 50.w,),
                            ],
                          ),
                      ],),
                      SizedBox(height: 10.h,),
                      Divider(color: black,height: 8.h,),
                      SizedBox(height: 10.h,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                        Row(
                          children: [
                            SizedBox(width: 20.w,),
                            text(context, 'اجمالي الطلب', 15, black),
                          ],
                        ),
                          Row(
                            children: [
                              text(context, '112 ر.س', 15, black),
                              SizedBox(width: 50.w,),
                            ],
                          ),
                      ],),
                      SizedBox(height: 10.h,),
                      Divider(color: black,),
                      SizedBox(height: 10.h,),
                      text(context, 'شكرا لتعاملكم مع منصتنا ,,, نتمنى لكم يوما رائعا', 17, black.withOpacity(0.75), fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h,),
                      Divider(color: black,),
                    ],
                  ),
               ),


            ],
          ),
        ],
      ),
    );
}
}