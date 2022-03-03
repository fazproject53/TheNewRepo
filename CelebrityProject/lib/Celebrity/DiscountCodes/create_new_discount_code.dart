///import section
import 'package:flutter/material.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewDiscountCode extends StatelessWidget {
  const CreateNewDiscountCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("إنشاء كود خصم جديد", context),
        body: const CreateNewDiscountCodeHome(),
      ),
    );
  }
}

///CreateNewDiscountCodeHome
class CreateNewDiscountCodeHome extends StatefulWidget {
  const CreateNewDiscountCodeHome({Key? key}) : super(key: key);

  @override
  State<CreateNewDiscountCodeHome> createState() =>
      _CreateNewDiscountCodeHomeState();
}

class _CreateNewDiscountCodeHomeState extends State<CreateNewDiscountCodeHome> {
  ///Text Field
  final _formKey = GlobalKey<FormState>();
  final TextEditingController discountCode = TextEditingController();
  final TextEditingController discountValue = TextEditingController();
  final TextEditingController numberOfUsers = TextEditingController();
  final TextEditingController description = TextEditingController();

  static DateTime current = DateTime.now();

  ///discount go to list
  List<String> goTo = ['اعلان', 'اهداء', 'مساحة'];

  ///_value
  int? _value = 1;

  ///Type of discount drop down list
  final List _testList = [
    {'no': 1, 'keyword': 'مئوي'},
    {'no': 2, 'keyword': 'نسبي'},
  ];

  ///
  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];

  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_testList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          alignment: Alignment.centerRight,
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ///Title
                        Container(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.h, right: 20.w),
                            child: text(context, "قم بإنشاء كود خصم جديد", 20,
                                ligthtBlack),
                          ),
                        ),

                        ///subTitle
                        Container(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, right: 20.w),
                            child: text(
                                context,
                                "يمكنك الان انشاء كود خصم جديد خاص بك يمكنك الان انشاء كود خصم\n جديد خاص بك",
                                12,
                                ligthtBlack),
                          ),
                        ),

                        ///--------------------------Text Field Section--------------------------
                        ///discount code
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldNoIcon(context, 'أدخل كود الخصم', 12, false,
                              discountCode, (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///Select The Type of Support
                        Container(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, right: 20.w),
                            child: text(
                                context, "اختر نوع الخصم", 18, ligthtBlack,
                                family: 'DINNextLTArabic'),
                          ),
                        ),

                        ///Type of discount
                        paddingg(
                          15,
                          15,
                          9,

                          ///The Radio Buttons
                          Container(
                            margin: EdgeInsets.only(top: 3.h, right: 2.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 1,
                                          groupValue: _value,
                                          activeColor: purple,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          }),
                                    ),
                                    text(context, "مبلغ ثابت", 14, ligthtBlack,
                                        family: 'DINNextLTArabic'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Radio<int>(
                                          value: 2,
                                          groupValue: _value,
                                          activeColor: purple,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          }),
                                    ),
                                    text(context, "نسبة مئوية", 14, ligthtBlack,
                                        family: 'DINNextLTArabic'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///-----------------------------------------------------
                        ///Value of discount
                        paddingg(
                          15,
                          15,
                          12,

                          ///-------in case with مبلغ ثابت the text will be ادخل مبلغ الخصم-------///
                          textFieldNoIcon(context, 'أدخل مبلغ الخصم', 12, false,
                              discountValue, (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///number of users
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldNoIcon(
                              context,
                              'أدخل عدد الاشخاص المستفيدين',
                              12,
                              false,
                              numberOfUsers, (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///description
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldDesc(
                            context,
                            'الوصف الخاص بكود الخصم',
                            12,
                            false,
                            description,
                            (String? value) {
                              /// Validation text field
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),

                        ///Check box
                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            padding(
                                8,
                                20,
                                text(context, 'الخصم الى', 14, black,
                                    fontWeight: FontWeight.bold)),
                            buildCkechboxList(goTo),
                          ],
                        ),

                        ///Determine the Start and end date
                        Container(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.h, right: 20.w),
                            child: text(
                                context,
                                "تحديد عدد الايام المتاح بها الكود",
                                18,
                                ligthtBlack),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 20.w, top: 10.h),
                          child: InkWell(
                            child: gradientContainerNoborder2(
                              120,
                              40,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    scheduale,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  text(context, 'تاريخ البداية', 15.sp, white,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                            onTap: () {
                              tableCalendar(context, current);
                            },
                          ),
                        ),
                        //end date
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 20.w, top: 10.h),
                          child: InkWell(
                            child: gradientContainerNoborder2(
                              120,
                              40,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    scheduale,
                                    color: white,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  text(context, 'تاريخ النهاية', 15.sp, white,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                            onTap: () {
                              tableCalendar(context, current);
                            },
                          ),
                        ),

                        ///Save box
                        SizedBox(
                          height: 50.h,
                        ),
                        padding(
                          15,
                          15,
                          gradientContainerNoborder(getSize(context).width,
                              buttoms(context, 'حفظ', 20, white, () {})),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
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
