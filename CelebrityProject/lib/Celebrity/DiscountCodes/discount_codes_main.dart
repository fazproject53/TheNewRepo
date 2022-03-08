///import section
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/celebrity/DiscountCodes/code_info.dart';
import 'package:celepraty/celebrity/DiscountCodes/create_new_discount_code.dart';
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountCodes extends StatelessWidget {
  const DiscountCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("أكواد الخصم", context),
        body: const HomeBodyDiscount(),
      ),
    );
  }
}

///-------------------------HomeBody Discount-------------------------
class HomeBodyDiscount extends StatefulWidget {
  const HomeBodyDiscount({Key? key}) : super(key: key);

  @override
  _HomeBodyDiscountState createState() => _HomeBodyDiscountState();
}

class _HomeBodyDiscountState extends State<HomeBodyDiscount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100.w,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: gradientContainerNoborder(
                        120.0,
                        buttoms(
                          context,
                          "انشاء كود جديد",
                          15,
                          white,
                              () {
                            ///Go to create a new discount code screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                    const CreateNewDiscountCode()));
                          },
                          evaluation: 0,
                        ),
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h, right: 20.w),
                    child: text(context, "الاكواد الحالية", 25, ligthtBlack),
                  ),
                ),
                ///Expanded ListView
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: ListView.builder(
                      itemCount: codeList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ExpansionTile(
                            title: text(
                                context, codeList[index].code, 16, black),
                            subtitle: text(
                                context, codeList[index].status, 16, green),
                            ///Inside each list
                            children: [
                              Container(

                                margin:
                                EdgeInsets.only(top: 10.h, right: 15.w),
                                height: 180.h,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ///Type of discount
                                      Row(
                                        children: [
                                          GradientIcon(
                                              typeOfDiscount,
                                              25.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          text(
                                            context,
                                            codeList[index].typeOfCode,
                                            15.sp,
                                            black,
                                          ),
                                        ],
                                      ),

                                      ///Number of users
                                      Row(
                                        children: [
                                          GradientIcon(
                                              numberOfUsers,
                                              25.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          text(
                                              context,
                                              codeList[index].numberOfUsers,
                                              15.sp,
                                              black),
                                        ],
                                      ),

                                      ///Discount go to
                                      Row(
                                        children: [
                                          GradientIcon(
                                              copun,
                                              25.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          text(
                                            context,
                                            codeList[index].codeGoTo,
                                            15.sp,
                                            black,
                                          ),
                                        ],
                                      ),

                                      ///Duration
                                      Row(
                                        children: [
                                          GradientIcon(
                                              duration,
                                              25.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          text(
                                            context,
                                            codeList[index].duration,
                                            15.sp,
                                            black,
                                          ),
                                        ],
                                      ),

                                      ///Description
                                      Row(
                                        children: [
                                          GradientIcon(
                                              discountDes,
                                              25.w,
                                              const LinearGradient(
                                                begin: Alignment(0.7, 2.0),
                                                end: Alignment(-0.69, -1.0),
                                                colors: [
                                                  Color(0xff0ab3d0),
                                                  Color(0xffe468ca)
                                                ],
                                                stops: [0.0, 1.0],
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          text(
                                            context,
                                            codeList[index].description,
                                            15.sp,
                                            black,
                                          ),
                                        ],
                                      ),

                                      ///Two button edit and delete
                                      Container(
                                        margin: EdgeInsets.only(left: 20.w),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              padding:
                                              EdgeInsets.only(right: 20.w),
                                              icon: Icon(editDiscount),
                                              color: black.withOpacity(0.8),
                                              onPressed: () {
                                                ///go to create new discount to edit the code
                                                print('edit');
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(removeDiscount),
                                              color: red?.withOpacity(0.8),
                                              onPressed: () {
                                                ///delete the discount code
                                                ///Alert dialog to conform
                                                print('delete');
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
