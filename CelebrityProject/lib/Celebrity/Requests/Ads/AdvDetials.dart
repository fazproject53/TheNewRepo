import 'dart:convert';
import 'package:celepraty/Celebrity/Requests/Ads/AdvertisinApi.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../Account/UserForm.dart';

class AdvDetials extends StatefulWidget {
  final int? i;
  final String? description;
  final String? image;
  final String? advTitle;
  final String? platform;
  final String? token;
  final int? state;
  final int? orderId;
  final int? price;
  const AdvDetials(
      {Key? key,
      this.i,
      this.description,
      this.image,
      this.advTitle,
      this.platform,
      this.token,
      this.orderId,
      this.state,
      this.price})
      : super(key: key);

  @override
  State<AdvDetials> createState() => _AdvDetialsState();
}

class _AdvDetialsState extends State<AdvDetials> {
  bool isAccepted = false;
  TextEditingController? price;
  List<String> rejectResonsList = [];
  GlobalKey<FormState> priceKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getRejectReson();
    print(widget.state);
    price = widget.price! > 0
        ? TextEditingController(text: '${widget.price}')
        : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // appBar: drowAppBar("تفاصيل الطلب",context),
          body: Column(children: [
//image-----------------------------------------------------
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            // height: double.infinity,
            margin: EdgeInsets.all(9.w),
            decoration: BoxDecoration(
                boxShadow: const [BoxShadow(blurRadius: 2)],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.image!,
                  ),
                  fit: BoxFit.fill,
                )),
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
//price--------------------------------------------------------------
//               child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: CircleAvatar(
//                       radius: 40.r,
//                       backgroundColor: pink,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: 15.r,
//                           ),
//                           text(context, "${widget.price}", 15, white,
//                               fontWeight: FontWeight.bold),
//                           SizedBox(
//                             width: 3.r,
//                           ),
//                           Icon(Icons.paid, size: 20.r),
//                         ],
//                       ))),
            ),
          ),
        ),
//ad title-----------------------------------------------------

        Container(
          //color: black,
          width: double.infinity,
          margin: EdgeInsets.only(left: 9.w, right: 9.w, bottom: 8.h, top: 8.h),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Icon(Icons.star_border_outlined, color: pink),
                  text(
                    context,
                    'اعلان ل' + widget.advTitle!,
                    20,
                    deepgrey!,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.justify,
                  ),
                  Spacer(),
//platform----------------------------------------------------------------
                  const Icon(Icons.star_border_outlined, color: pink),
                  text(
                    context,
                    'اعلان علي  ${widget.platform}',
                    20,
                    deepgrey!,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.justify,
                  ),
                ],
              )),
        ),
//description----------------------------------------------------------------------
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              //height:MediaQuery.of(context).size.height/6,
              //color: Colors.red,
              margin: EdgeInsets.only(
                  left: 13.w, right: 13.w, bottom: 8.h, top: 8.h),
              child: text(
                context,
                widget.description!,
                15,
                grey!,
                fontWeight: FontWeight.bold,
                align: TextAlign.justify,
              ),
            ),
          ),
        ),
//price field-----------------------------------------------------
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: priceKey,
            child: textField2(
              context,
              money,
              widget.price! > 0 ? "سعر الاعلان" : 'أدخل سعر الاعلان',
              14,
              false,
              price!,
              empty,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              isEdit: widget.price! > 0 ? true : false,
            ),
          ),
        ),

//accept buttom-----------------------------------------------------

        Container(
            width: double.infinity,
            height: 50,
            //color: Colors.red,
            margin: EdgeInsets.all(20.r),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: gradientContainer(
                  double.infinity,
                  buttoms(
                    context,
                    widget.state == 4
                        ? "لقد قبلت الطلب"
                        : widget.state == 3
                            ? '----'
                            : "قبول",
                    15,
                    white,
                    widget.state == 4 || widget.state == 3
                        ? null
                        : () {
                            if (priceKey.currentState?.validate() == true) {
                              loadingDialogue(context);
                              Future<bool> result = acceptAdvertisingOrder(
                                  widget.token!,
                                  widget.orderId!,
                                  int.parse(price!.text));
                              result.then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(context, 'تم قبول الطلب', green,
                                          done));
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(context, 'تم قبول الطلب مسبقا',
                                          red, error));
                                }
                              });
                            }
                          },
                    evaluation: 0,
                  ),
                  height: 50,
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),

//reject buttom-------------------------------------------------

              Expanded(
                flex: 2,
                child: gradientContainer(
                  double.infinity,
                  buttoms(
                    context,
                    widget.state == 3
                        ? "لقد رفضت الطلب "
                        : widget.state == 4
                            ? '----'
                            : 'رفض',
                    15,
                    widget.state == 3 || widget.state == 4 ? deepgrey! : black,
                    widget.state == 4 || widget.state == 3
                        ? null
                        : () {
                            showBottomSheetModel(context);
                          },
                    //evaluation: 1,
                  ),
                  height: 50,
                  gradient: true,
                  color: pink,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
//---------------------------------------------------------
              Expanded(
                child: Row(
                  children: const [
                    Expanded(
                        flex: 1,
                        //child:
                        //  gradientContainer(
                        //   double.infinity,
                        //   InkWell(
                        //       onTap: () {
                        //         print("go to chat home");
                        //       },
                        child: Icon(Icons.forum_outlined, color: pink))
                  ],
                ),
              ),
              //height: 50,
              //gradient: true,
              //),
              //)
            ])),
      ])),
    );
  }

  void getRejectReson() async {
    String url = "https://mobile.celebrityads.net/api/reject-resons";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      for (int i = 0; i < body['data'].length; i++) {
        rejectResonsList.add(body['data'][i]['name']);
      }
      print(rejectResonsList);
    } else {
      throw Exception('Failed to load celebrity catogary');
    }
  }

  showBottomSheetModel(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        elevation: 10,
        backgroundColor: white,
        //isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)),
          //side: BorderSide(color: Colors.white, width: 1),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: text(
                  context,
                  'إختر سبب الرفض',
                  18,
                  black,
                  //fontWeight: FontWeight.bold,
                  align: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: ListView.builder(
                    itemCount: rejectResonsList.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding:  EdgeInsets.all(5.0.r),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
                          tileColor: deepPink,
                          title: Center(
                            child: text(
                              context,
                              rejectResonsList[i],
                              15,
                              white,
                              fontWeight: FontWeight.bold,
                              align: TextAlign.justify,
                            ),
                          ),
                          onTap:(){
                            print('obbbbb');
                          },
                        ),
                      );
                    }),
              ),
            ],
          );
        });
  }
}
//
