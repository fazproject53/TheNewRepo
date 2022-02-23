///import section
import 'package:flutter/material.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactWithUsMain extends StatefulWidget {
  const ContactWithUsMain({Key? key}) : super(key: key);

  @override
  _ContactWithUsMainState createState() => _ContactWithUsMainState();
}

class _ContactWithUsMainState extends State<ContactWithUsMain> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("الدعم الفني", context),
        body: const ContactWithUsHome(),
      ),
    );
  }
}

///----------------------------ContactWithUsHome----------------------------
class ContactWithUsHome extends StatefulWidget {
  const ContactWithUsHome({Key? key}) : super(key: key);

  @override
  _ContactWithUsHomeState createState() => _ContactWithUsHomeState();
}

class _ContactWithUsHomeState extends State<ContactWithUsHome> {
  ///Text Field
  final TextEditingController supportName = TextEditingController();
  final TextEditingController supportEmail = TextEditingController();
  final TextEditingController supportPhone = TextEditingController();
  final TextEditingController supportTitle = TextEditingController();
  final TextEditingController supportDescription = TextEditingController();
  final TextEditingController supportAddNew = TextEditingController();

  ///formKey
  final _formKey = GlobalKey<FormState>();

  ///Type of discount drop down list
  final List _testList = [
    {'no': 1, 'keyword': 'دعم فني'},
    {'no': 2, 'keyword': 'إستفسار'},
    {'no': 3, 'keyword': 'صيانة'},
    {'no': 3, 'keyword': 'سوال'},
    {'no': 3, 'keyword': 'إستفسار'}
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
      bottom: false,
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
                            child: text(context, "قم بملئ البيانات التالية", 20,
                                ligthtBlack,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        ///--------------------------Text Field Section--------------------------
                        ///Enter Your Name
                        paddingg(
                          15,
                          15,
                          15,
                          textFieldNoIcon(
                              context, 'الاسم', 12, false, supportName,
                              (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///Enter Your Email
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldNoIcon(context, 'البريد الالكتروني', 12,
                              false, supportEmail, (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///Enter Your Phone Number
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldNoIcon(
                              context, 'رقم الجوال', 12, false, supportPhone,
                              (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///Dropdown Below
                        paddingg(
                          15,
                          15,
                          12,
                          DropdownBelow(
                            itemWidth: 380.w,
                            ///text style inside the menu
                            itemTextstyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: black,
                                fontFamily: 'Cairo',),
                            ///hint style
                            boxTextstyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: grey,
                                fontFamily: 'Cairo'),
                            ///box style
                            boxPadding:
                                EdgeInsets.fromLTRB(13.w, 12.h, 13.w, 12.h),
                            boxWidth: 500.w,
                            boxHeight: 40.h,
                            boxDecoration: BoxDecoration(
                                color: textFieldBlack2.withOpacity(0.70),
                                borderRadius: BorderRadius.circular(8.r)),
                            ///Icons
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white54,
                            ),
                            hint: const Text(
                              'اختر نوع الشكوى',
                              textDirection: TextDirection.rtl,
                            ),
                            value: _selectedTest,
                            items: _dropdownTestItems,
                            onChanged: onChangeDropdownTests,
                          ),
                        ),

                        ///Title
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldNoIcon(
                              context, 'موضوع الرسالة', 12, false, supportTitle,
                              (String? value) {
                            /// Validation text field
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }, false),
                        ),

                        ///Description
                        paddingg(
                          15,
                          15,
                          12,
                          textFieldDesc(
                            context,
                            'تفاصيل الرسالة',
                            12,
                            false,
                            supportDescription,
                            (String? value) {
                              /// Validation text field
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),

                        ///Save box
                        Container(
                          margin: EdgeInsets.only(
                              top: 20.h, right: 20.w, left: 20.w, bottom: 20.h),
                          child: gradientContainerNoborder(500.w,
                              buttoms(context, 'إرسال', 15, white, () {})),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
