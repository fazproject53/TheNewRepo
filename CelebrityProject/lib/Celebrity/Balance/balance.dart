///import section
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'radioListTile.dart';

class BalanceMain extends StatelessWidget {
  const BalanceMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('الرصيد', context),
        body: const BalanceHome(),
      ),
    );
  }
}

///-------------------------balance section-------------------------
class BalanceHome extends StatefulWidget {
  const BalanceHome({Key? key}) : super(key: key);

  @override
  _BalanceHomeState createState() => _BalanceHomeState();
}

class _BalanceHomeState extends State<BalanceHome> {
  bool isSecureMode = false;

  ///Text Filed
  final TextEditingController selectedCVV = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();
  final TextEditingController creditCardDateController =
      TextEditingController();
  final TextEditingController creditCardCvvController = TextEditingController();
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: purple.withOpacity(0.4),
        width: 1.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              child: text(context, "الرصيد الخاص بك", 19, ligthtBlack),
            ),
          ),

          ///The Account Balance
          Padding(
            padding: EdgeInsets.only(top: 16.h, right: 20.w, left: 20.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 10.h, left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Icon
                        GradientIcon(
                            payment,
                            27.w,
                            const LinearGradient(
                              begin: Alignment(0.7, 2.0),
                              end: Alignment(-0.69, -1.0),
                              colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                              stops: [0.0, 1.0],
                            )),
                        SizedBox(
                          width: 2.w,
                        ),

                        ///Text
                        text(
                          context,
                          'رصيد الحساب',
                          20.sp,
                          black,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: grey,
                    height: 20.h,
                    thickness: 0.5,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.h),
                    child: text(context, "500 ر.س", 16, ligthtBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          ///The Suspend Balance
          Padding(
            padding: EdgeInsets.only(top: 16.h, right: 20.w, left: 20.w),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.r),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, bottom: 10.h, left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Icon
                        GradientIcon(
                            payment,
                            27.w,
                            const LinearGradient(
                              begin: Alignment(0.7, 2.0),
                              end: Alignment(-0.69, -1.0),
                              colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                              stops: [0.0, 1.0],
                            )),
                        SizedBox(
                          width: 2.w,
                        ),

                        ///Text
                        text(
                          context,
                          'الرصيد المعلق',
                          20.sp,
                          black,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: grey,
                    height: 20.h,
                    thickness: 0.5,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.h),
                    child: text(context, "500 ر.س", 16, ligthtBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          ///Withdrew Money Button
          padding(
            22,
            22,
            gradientContainerNoborder(
                getSize(context).width,
                buttoms(context, 'سحب الرصيد', 20, white, () {
                  ///Bottom sheet
                  showBottomSheetWhite(
                      context, bottomSheetMenuPayments('1', 'rayana', '500'));
                })),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  ///Bottom Sheet for Payments
  Widget bottomSheetMenuPayments(String id, String name, String balance) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      text(
                        context,
                        'أختر طريقة الدفع',
                        16,
                        black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  ///--------------------------
                  Visibility(
                      visible: true,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                              height: 100.h,
                              child: RadioWidgetDemo()),
                        ],
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          add,
                          size: 23,
                          color: black,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        text(
                          context,
                          'إضافة بطاقة جديدة',
                          18,
                          black,
                        ),
                        SizedBox(
                          width: 170.w,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(
                            backIcon,
                            size: 20,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      ///Go To New Bottom Sheet To Add New Credit Card
                      ///Bottom sheet
                      showBottomSheetWhite2(
                          context, bottomSheetCreditCard('1', 'rayana', '500'));
                    },
                  ),
                  Divider(
                    thickness: 1,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(context, 'الإجمالي المستحق', 16, black,
                          fontWeight: FontWeight.bold),
                      text(context, '140' + ' ريال', 16, black,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  ///bottom to withdraw balance
                  padding(
                    22,
                    22,
                    gradientContainerNoborder(150.w,
                        buttoms(context, 'إسحب الرصيد', 15, white, () {})),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheetCreditCard(String id, String name, String balance) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text(
                            context,
                            'إضافة بطاقة جديدة',
                            18,
                            black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Column(
                          children: <Widget>[
                            SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    CreditCardForm(
                                      formKey: formKey,
                                      obscureCvv: true,
                                      obscureNumber: true,
                                      cardNumber: cardNumber,
                                      cvvCode: cvvCode,
                                      isCardNumberVisible: true,
                                      isExpiryDateVisible: true,
                                      expiryDate: expiryDate,
                                      themeColor: purple,
                                      textColor: Colors.white,
                                      cardNumberDecoration: InputDecoration(
                                        labelText: 'رقم البطاقة',
                                        hintText: 'XXXX XXXX XXXX XXXX',
                                        hintStyle:  TextStyle(
                                            color: Colors.black, fontSize: 12.sp,fontFamily: 'Cairo' ),
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14.sp,fontFamily: 'Cairo' ),
                                        focusedBorder: border,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: grey!.withOpacity(0.8),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      expiryDateDecoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 12.sp,fontFamily: 'Cairo' ),
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14.sp,fontFamily: 'Cairo' ),
                                        focusedBorder: border,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: grey!.withOpacity(0.8),
                                            width: 1.0,
                                          ),
                                        ),
                                        labelText: 'تاريخ الانتهاء',
                                        hintText: 'XX/XX',
                                      ),
                                      cvvCodeDecoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Colors.black, fontSize: 12.sp,fontFamily: 'Cairo' ),
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14.sp,fontFamily: 'Cairo' ),
                                        focusedBorder: border,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: grey!.withOpacity(0.8),
                                            width: 1.0,
                                          ),
                                        ),
                                        labelText: 'رمز التحقق' + 'CVV',
                                        hintText: 'XXX',
                                      ),

                                      onCreditCardModelChange:
                                          onCreditCardModelChange,
                                    ),
                                  ],
                                ),
                              ),

                          ],
                        ),

                      SizedBox(
                        height: 20.h,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text(context, 'الإجمالي المستحق', 16, black,
                              fontWeight: FontWeight.bold),
                          text(context, '140' + ' ريال', 16, black,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),

                      ///bottom to withdraw balance
                      padding(
                        22,
                        22,
                        gradientContainerNoborder(150.w,
                            buttoms(context, 'إسحب الرصيد', 15, white, () {

                              if (formKey.currentState!.validate()) {
                              print('valid!');
                              } else {
                              print('invalid!');
                              }

                            })),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
