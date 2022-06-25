import 'package:celepraty/Models/Variables/Variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../Models/Methods/method.dart';

import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../SuccessfulAndFailureScreens/failure_screen.dart';
import '../../SuccessfulAndFailureScreens/successful_screen.dart';

class UserRechargeBalance extends StatefulWidget {
  const UserRechargeBalance({Key? key}) : super(key: key);

  @override
  _UserRechargeBalanceState createState() => _UserRechargeBalanceState();
}

class _UserRechargeBalanceState extends State<UserRechargeBalance> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController cvvCode1 = TextEditingController();
  List<User>? users;
  User? selectedUser;
  int? selectedRadio;
  int? selectedRadioTile;
  OutlineInputBorder? border;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getUsers();

    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: purple.withOpacity(0.6),
        width: 1.0,
      ),
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  ///Credit card section
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('إضافة رصيد', context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              SizedBox(
                  height: 180.h,
                  width: 180.w,
                  child: Lottie.asset('assets/lottie/lf30_editor_4r6m79m8.json')),
              text(context, 'ادخل المبلغ المراد شحنه', 16,
                  black.withOpacity(0.6)),
              SizedBox(
                height: 20.h,
              ),
              textFieldSmall(
                context,
                '',
                14,
                false,
                amount,
                (String? value) {},
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const Spacer(),
              padding(
                22,
                22,
                gradientContainerNoborder(
                    getSize(context).width,
                    buttoms(context, 'التالي', 16, white, () {
                      ///Bottom sheet
                      if (amount.text.isNotEmpty) {
                        showBottomSheetWhite(context,
                            bottomSheetRechargeMenu('1', 'rayana', '500'));
                      } else {
                        flushBar(
                            context, 'Erorr', 'Enter amount of money first');
                      }
                    })),
              ),
              SizedBox(
                height: 60.h,
              )
            ],
          ),
        ),
      ),
    );

  }


   splash() {
    return Scaffold(
      backgroundColor: white.withOpacity(0.7),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.only(top: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(
                  height: 260.h,
                  width: 260.w,
                  child: Lottie.asset('assets/lottie/lf30_editor_4r6m79m8.json')),
              text(context, 'إضافة ٢٠ ريال للرصيد', 20, black,
                  align: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }


  Widget bottomSheetRechargeMenu(String id, String name, String balance) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 18.w, left: 20.w),
                child: Column(
                  children: [
                    text(
                      context,
                      'أختر طريقة الشحن',
                      16,
                      black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Divider(
                      thickness: 1,
                    ),

                    ///Apple pay
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //applePayIcon.png
                          Column(
                            children: [
                              Container(
                                height: 20.h,
                                width: 30.w,
                                child: Image.asset(
                                    'assets/image/applePayIcon.png'),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          text(
                            context,
                            'Apple Pay',
                            18,
                            black,
                          ),
                          SizedBox(
                            width: 230.w,
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
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),

                    ///credit card
                    Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: createRadioListUsers(),
                              ),
                            ),
                          ],
                        )),

                    const Divider(
                      thickness: 1,
                    ),

                    ///add new credit card
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
                        showBottomSheetWhite(context,
                            bottomSheetNewCreditCard('1', 'rayana', '500'));
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    ///bottom to withdraw balance
                    Visibility(
                      ///will show when the user choose one of the available credit card
                      visible: true,
                      child: padding(
                        22,
                        22,
                        gradientContainerNoborder(
                            150.w,
                            buttoms(context, 'إضافة رصيد', 15, white, () {
                              ///loading Screen

                              ///then the verification with the bank
                              ///successful animation
                            })),
                      ),
                    ),

                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (User user in users!) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: selectedUser,
          title: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Directionality(
                      textDirection: TextDirection.ltr,
                      child: text(context, user.firstName, 14, black)),

                  ///Text Filed
                  Visibility(
                    visible: selectedUser == user,
                    child: Column(
                      children: [
                        textFieldSmall(
                          context,
                          'رمز التحقق ' 'CVV',
                          12,
                          false,
                          cvvCode1,
                          (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'حقل اجباري';
                            }
                            if (value.startsWith('0')) {
                              return 'يجب ان لا يبدا بصفر';
                            }
                            if (value.length > 3) {
                              return 'no';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          onChanged: (User? currentUser) {
            print("Current User ${currentUser?.firstName}");

            setSelectedUser(currentUser!);
          },
          selected: selectedUser == user,
          activeColor: purple,
        ),
      );
    }
    return widgets;
  }

  ///BottomSheet to Add New Credit Card
  Widget bottomSheetNewCreditCard(String id, String name, String balance) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.h,
            ),
            text(context, 'إضافة بطاقة جديدة', 16, black,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///Icon
                Icon(
                  protect,
                  size: 20,
                  color: darkBlue,
                ),
                SizedBox(
                  width: 5.w,
                ),

                ///text
                text(context, 'يتم حفظ معلومات الدفع الخاصة بك بشكل آمن', 12,
                    black.withOpacity(0.6))
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    cardHolderName: '',
                    formKey: formKey,
                    obscureCvv: true,
                    isHolderNameVisible: false,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    expiryDate: expiryDate,
                    themeColor: purple,
                    textColor: Colors.black,
                    cardNumberDecoration: InputDecoration(
                      labelText: 'رقم البطاقة',
                      hintText: '0000 0000 0000 0000',
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
                      focusedBorder: border,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey!.withOpacity(0.8),
                          width: 1.0,
                        ),
                      ),
                    ),
                    numberValidationMessage: 'يرجى إضافة رقم البطاقة',
                    expiryDateDecoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
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
                    dateValidationMessage:
                        'يرجى إضافة تاريخ انتهاء صلاحية البطاقة',
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Cairo'),
                      focusedBorder: border,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: grey!.withOpacity(0.8),
                          width: 1.0,
                        ),
                      ),
                      labelText: 'رمز التحقق' + 'CVV',
                      hintText: '000',
                    ),
                    cvvValidationMessage: 'ادخل رمز التحقق',
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  padding(
                    22,
                    22,
                    gradientContainerNoborder(
                        170.w,
                        buttoms(context, 'التحقق من البطاقة', 15, white, () {
                          ///Loading screen

                          if (formKey.currentState!.validate()) {
                            ///loading Screen
                            goTopagepush(context, splash());
                            ///then the verification with the bank

                            ///successful animation
                            goTopagepush(context, const SuccessfulScreen());
                          } else {
                            ///successful animation
                            goTopagepush(context, const FailureScreen());
                          }
                        })),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///user class
class User {
  int userId;
  String firstName;

  User({
    required this.userId,
    required this.firstName,
  });

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "**** **** **** 4958"),
      User(userId: 2, firstName: "**** **** **** 4323"),
    ];
  }
}


