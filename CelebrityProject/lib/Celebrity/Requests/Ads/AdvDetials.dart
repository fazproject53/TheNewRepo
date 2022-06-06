import 'dart:convert';
import 'package:celepraty/Celebrity/Requests/Ads/AdvertisinApi.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/chat/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../Account/UserForm.dart';
import '../../chat/chat_Screen.dart';
import 'Advertisments.dart';

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
  final String? rejectResonName;
  final int? rejectResonId;
  const AdvDetials({
    Key? key,
    this.i,
    this.description,
    this.image,
    this.advTitle,
    this.platform,
    this.token,
    this.orderId,
    this.state,
    this.price,
    this.rejectResonName,
    this.rejectResonId,
  }) : super(key: key);

  @override
  State<AdvDetials> createState() => _AdvDetialsState();
}

class _AdvDetialsState extends State<AdvDetials>
    with AutomaticKeepAliveClientMixin {
  int? resonRejectId;
  String? resonReject;
  bool isReject = true;
  TextEditingController? price;
  TextEditingController reson = TextEditingController();
  List<String> rejectResonsList = [];
  GlobalKey<FormState> priceKey = GlobalKey();
  GlobalKey<FormState> resonKey = GlobalKey();

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
          flex: 2,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 2.4,
                maxHeight: MediaQuery.of(context).size.height / 2.4),
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
              ),
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
                  const Spacer(),
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
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              //height:MediaQuery.of(context).size.height/6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
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
        Visibility(
            visible: isReject,
            child: widget.state == 3 || widget.state == 5
                ? Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                            context,
                            'سبب الرفض',
                            18,
                            deepgrey!,
                            fontWeight: FontWeight.bold,
                            align: TextAlign.right,
                          ),
                          //-------------------------------
                          text(
                            context,
                            widget.rejectResonName!,
                            18,
                            deepBlack,
                            //fontWeight: FontWeight.bold,
                            align: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  )
                :
//price field-------------------------------------------------------------------------------
                Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: SingleChildScrollView(
                      child: Form(
                        key: priceKey,
                        child: textField2(
                          context,
                          money,
                          widget.price! > 0
                              ? "سعر الاعلان"
                              : 'أدخل سعر الاعلان',
                          14,
                          false,
                          price!,
                          empty,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          isEdit: widget.price! > 0 ? false : true,
                        ),
                      ),
                    ),
                  )),

//accept buttom-----------------------------------------------------

        isReject
            ? Container(
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
                                ? 'قبول'
                                : widget.state == 2
                                    ? 'قبول من المتابع'
                                    : "قبول",
                        15,
                        widget.state == 4 ||
                                widget.state == 3 ||
                                widget.state == 2 ||
                                widget.state == 5
                            ? deepBlack
                            : white,
                        widget.state == 4 ||
                                widget.state == 3 ||
                                widget.state == 2 ||
                                widget.state == 5
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(context,
                                              'تم قبول الطلب', green, done));
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              context,
                                              'تم قبول الطلب مسبقا',
                                              red,
                                              error));
                                    }
                                  });
                                }
                              },
                        evaluation: 0,
                      ),
                      height: 50,
                      color: widget.state == 4 ||
                              widget.state == 3 ||
                              widget.state == 2 ||
                              widget.state == 5
                          ? deepBlack
                          : Colors.transparent,
                      gradient: widget.state == 4 ||
                              widget.state == 3 ||
                              widget.state == 2 ||
                              widget.state == 5
                          ? true
                          : false,
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
                                ? 'رفض'
                                : widget.state == 5
                                    ? 'رفض من المتابع'
                                    : 'رفض',
                        15,
                        widget.state == 3 ||
                                widget.state == 4 ||
                                widget.state == 5 ||
                                widget.state == 2
                            ? deepgrey!
                            : black,
                        widget.state == 4 ||
                                widget.state == 3 ||
                                widget.state == 5 ||
                                widget.state == 2
                            ? null
                            : () {
                                rejectResonsList.isNotEmpty
                                    ? showBottomSheetModel(context)
                                    : '';
                              },
                        //evaluation: 1,
                      ),
                      height: 50,
                      gradient: true,
                      color: widget.state == 3 ||
                              widget.state == 4 ||
                              widget.state == 5 ||
                              widget.state == 2
                          ? deepBlack
                          : pink,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
//---------------------------------------------------------
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: widget.state == 3
                                    ? null
                                    : () {
                                        goTopagepush(context, chatScreen());
                                      },
                                child: Icon(Icons.forum_outlined,
                                    color:
                                        widget.state == 3 ? deepBlack : pink)))
                      ],
                    ),
                  ),
                  //height: 50,
                  //gradient: true,
                  //),
                  //)
                ]))
            :
//confirm reject---------------------------------------------------------------
            Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                      child: text(
                        context,
                        'سبب الرفض',
                        18,
                        deepgrey!,
                        fontWeight: FontWeight.bold,
                        align: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 15.h),
//-------------------------------------------------------------------------
                    resonReject == 'أخرى'
                        ? Form(
                            key: resonKey,
                            child: textField2(
                              context,
                              Icons.unpublished,
                              '',
                              14,
                              false,
                              reson,
                              empty,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: text(
                              context,
                              '$resonReject',
                              18,
                              deepBlack,
                              //fontWeight: FontWeight.bold,
                              align: TextAlign.right,
                            ),
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height / 8),
                    //--------------------------------
                    //const Spacer(),
                    gradientContainer(
                      double.infinity,
                      buttoms(
                        context,
                        "تاكيد",
                        15,
                        white,
                        () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (resonReject == 'أخرى') {
                            if (resonKey.currentState?.validate() == true) {
                              loadingDialogue(context);
                              Future<bool> result = rejectAdvertisingOrder(
                                  widget.token!,
                                  widget.orderId!,
                                  reson.text,
                                  0);
                              result.then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(context, 'تم رفض الطلب', green,
                                          done));
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(context, 'تم رفض الطلب مسبقا',
                                          red, error));
                                }
                              });

                            }
                          } else {
                            loadingDialogue(context);
                            Future<bool> result = rejectAdvertisingOrder(
                                widget.token!,
                                widget.orderId!,
                                resonReject!,
                                resonRejectId!);
                            result.then((value) {
                              if (value == true) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar(
                                        context, 'تم رفض الطلب', green, done));
                              } else {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar(context, 'تم رفض الطلب مسبقا', red,
                                        error));
                              }
                            });
                          }
                        },
                        evaluation: 0,
                      ),
                      height: 50,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
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
    } else {
      throw Exception('Failed to load celebrity catogary');
    }
  }

//----------------------------------------------------------------------------------------------
  showBottomSheetModel(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        elevation: 10,
        backgroundColor: black,
        //isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(70.r), topLeft: Radius.circular(70.r)),
          //side: BorderSide(color: Colors.white, width: 1),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 10),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  width: MediaQuery.of(context).size.width / 9,
                  height: 4.h,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
//Reject reson-----------------------------------------------------------------------------
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7.h,
                  child: ListView.builder(
                      itemCount: rejectResonsList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0.w, vertical: 3.h),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                resonReject = rejectResonsList[i];
                                resonRejectId = i;
                                isReject = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 46.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  color: deepPink),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: text(
                                  context,
                                  rejectResonsList[i],
                                  15,
                                  white,
                                  fontWeight: FontWeight.bold,
                                  align: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
//Another reson-----------------------------------------------------------------------------

              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 3.h),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      resonReject = 'أخرى';
                      isReject = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 46.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: deepPink),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: text(
                        context,
                        'أخرى',
                        15,
                        white,
                        fontWeight: FontWeight.bold,
                        align: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
//
