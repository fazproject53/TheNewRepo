
import 'dart:convert';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;



class gifttingForm extends StatefulWidget{

  final String? id, image, name;
  const gifttingForm({Key? key,  this.id, this.image, this.name}) : super(key: key);
  _gifttingFormState createState() => _gifttingFormState();
}

class _gifttingFormState extends State<gifttingForm>{
  final _formKey = GlobalKey<FormState>();
  Future<GiftType>? types;
  Future<OccasionType>? otypes;

  final TextEditingController desc = new TextEditingController();
  final TextEditingController from = new TextEditingController();
  final TextEditingController to = new TextEditingController();
  final TextEditingController copun = new TextEditingController();

  DateTime current = DateTime.now();
  String ocassion = 'اختر المناسبة الخاصة';
  String type = 'نوع الاهداء';
  var ocassionlist =[];
  var typelist =[];

   bool check =false;
   bool  warn = false;
  bool  datewarn = false;
  List<DropdownMenuItem<Object?>> _dropdownTestItem = [];
  List<DropdownMenuItem<Object?>> _dropdownTestItem2 = [];

  ///_value
  var _selectedTest;
  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest = selectedTest;
    });
  }

  var _selectedTest2;
  onChangeDropdownTests2(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTest2 = selectedTest;
    });
  }

  @override
  void initState() {
    types = getGiftType();
    otypes = getOcassionType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    print(_dropdownTestItem2.length);


          return  Directionality(
            textDirection: TextDirection.rtl,
            child:Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: drowAppBar('طلب اهداء', context),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(height: 365.h,
                              width: 1000.w,
                              child: Image.network(widget.image!, color: Colors.white.withOpacity(0.60), colorBlendMode: BlendMode.modulate,fit: BoxFit.cover,)),
                           Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('اطلب اهداء\n' + 'شخصي من ' + widget.name! + ' الان',
                              style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17, color: white , fontFamily: 'Cairo'), ),
                          ),
                        ]),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: paddingg(12, 12, 5, Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 20.h,),
                              padding(10, 12, Container( alignment : Alignment.topRight,child:  text(context, ' قم بملئ   البيانات التالية',18,textBlack,fontWeight: FontWeight.normal,
                                family: 'Cairo', )),),

                              //========================== form ===============================================


                              const SizedBox(height: 30,),

                              FutureBuilder(
                                  future: otypes,
                                  builder: ((context, AsyncSnapshot<OccasionType> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return  paddingg(15, 15, 12,
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
                                          hint:  Text(
                                            ocassion,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          value: _selectedTest,
                                          items: _dropdownTestItem,
                                          onChanged: onChangeDropdownTests,
                                        ),
                                      );
                                    } else if (snapshot.connectionState == ConnectionState.active ||
                                        snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Center(child: Text(snapshot.error.toString()));
                                        //---------------------------------------------------------------------------
                                      } else if (snapshot.hasData) {
                                        _dropdownTestItem.isEmpty?{
                                        ocassionlist.add({'no': 0, 'keyword': 'اختر نوع المناسبة'}),
                                        for(int i =0; i< snapshot.data!.data!.length; i++) {
                                          ocassionlist.add({'no': snapshot.data!.data![i].id!, 'keyword': '${snapshot.data!.data![i].name!}'}),
                                        },
                                        _dropdownTestItem = buildDropdownTestItems(ocassionlist)
                                        } : null;

                                        return   paddingg(15, 15, 12,
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
                                            hint:  Text(
                                              ocassion,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: _selectedTest,
                                            items: _dropdownTestItem,
                                            onChanged: onChangeDropdownTests,
                                          ),
                                        );
                                      } else {
                                        return const Center(child: Text('لايوجد لينك لعرضهم حاليا'));
                                      }
                                    } else {
                                      return Center(
                                          child: Text('State: ${snapshot.connectionState}'));
                                    }
                                  })),

                              FutureBuilder(
                                  future: types,
                                  builder: ((context, AsyncSnapshot<GiftType> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return  paddingg(15, 15, 12,
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
                                          hint:  Text(
                                            type,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          value: _selectedTest2,
                                          items: _dropdownTestItem2,
                                          onChanged: onChangeDropdownTests2,
                                        ),
                                      );
                                    } else if (snapshot.connectionState == ConnectionState.active ||
                                        snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return Center(child: Text(snapshot.error.toString()));
                                        //---------------------------------------------------------------------------
                                      } else if (snapshot.hasData) {
                                        _dropdownTestItem2.isEmpty?{
                                        typelist.add({'no': 0, 'keyword': 'نوع الاهداء'}),
                                        for(int i =0; i< snapshot.data!.data!.length; i++) {
                                          typelist.add({'no': snapshot.data!.data![i].id!, 'keyword': '${snapshot.data!.data![i].name!}'}),
                                        },
                                        _dropdownTestItem2 = buildDropdownTestItems(typelist),
                                        } : null;

                                        return paddingg(15, 15, 12,
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
                                            hint:  Text(
                                              type,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: _selectedTest2,
                                            items: _dropdownTestItem2,
                                            onChanged: onChangeDropdownTests2,
                                          ),
                                        );
                                      } else {
                                        return const Center(child: Text('لايوجد لينك لعرضهم حاليا'));
                                      }
                                    } else {
                                      return Center(
                                          child: Text('State: ${snapshot.connectionState}'));
                                    }
                                  })),


                              Row(
                                children: [
                                  Expanded(
                                    child: paddingg(3.w, 15.w, 12.h,textFieldNoIcon(context, 'من', 14.sp, false, from,(String? value) {
                                      if (value == null || value.isEmpty) {
                                      return 'حقل اجباري';} return null;},false),),),
                                  Expanded(
                                    child: paddingg(15.w, 3.w, 12.h,textFieldNoIcon(context, 'الى', 14.sp, false, to,(String? value) {if (value == null || value.isEmpty) {
                                      return 'حقل اجباري';} return null;}, false),),
                                  ),

                                ],
                              ),

                              paddingg(15.w, 15.w, 12.h,textFieldDesc(
                                context,'الوصف الخاص بالاهداء', 14.sp, false, desc,(String? value) {
                                  if (value == null || value.isEmpty) {
                                return 'حقل اجباري';
                                  } return null;},),),
                              paddingg(15.w, 15.w, 12.h,textFieldNoIcon(context, 'ادخل كود الخصم', 14.sp, false, copun,(String? value) { return null;},true),),


                              paddingg(15.w, 15.w, 15.h,SizedBox(height: 45.h,child: InkWell(
                                child: gradientContainerNoborder(50.w, Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(scheduale, color: white,),
                                    SizedBox(width: 15.w,),
                                    text(context, 'تاريخ الاهداء', 15.sp, white, fontWeight: FontWeight.bold),
                                  ],
                                )),onTap: () async {  DateTime? endDate =
                              await showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                        data: ThemeData.light().copyWith(
                                            colorScheme:
                                            const ColorScheme.light(primary: purple, onPrimary: white)),
                                        child: child!);}
                                  context:
                                  context,
                                  initialDate:
                                  current,
                                  firstDate:
                                  DateTime(
                                      2000),
                                  lastDate:
                                  DateTime(
                                      2100));
                              if (endDate == null)
                                return;
                              setState(() {
                                current= endDate;
                              });},
                              )),),

                              paddingg(15.w, 20.w, 5.h,text(context,datewarn?'الرجاء اختيار تاريخ الاهداء':'', 12,red!,)),

                              paddingg(0,0,12.h, CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: text(context,'عند طلب الاهداء، فإنك توافق على شروط الإستخدام و سياسة الخصوصية الخاصة بـ', 10, black, fontWeight: FontWeight.bold,family:'Cairo'),
                                value: check,
                                selectedTileColor: warn == true? red: black,
                                subtitle: Text(warn == true?'حتى تتمكن من طلب الاهداء يجب الموافقة على الشروط والاحكام':'' ,style: TextStyle(color: red , fontSize: 10.sp, fontFamily:'Cairo'),),
                                onChanged: (value) {
                                  setState(() {
                                    setState(() {
                                      check = value!;
                                    });
                                  });
                                },)

                                ,),
                              SizedBox(height: 30.h,),
                              check? padding(15.w, 15.w, gradientContainerNoborder(getSize(context).width,
                                buttoms(context, 'رفع الطلب', 15, white, (){
                                _formKey.currentState!.validate()?{
                                check && current.day != DateTime.now().day?{
                                addGift().whenComplete(() =>   {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                const SnackBar(
                                content: Text(
                                "تم ارسال طلبك بنجاح"),
                                ))
                                })
                                } : setState((){ !check? warn = true: false;
                                current.day == DateTime.now().day? datewarn = true: false;}),
                                }: null;
                                }),)):

                              padding(15, 15, Container(width: getSize(context).width,
                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(15.r),   color: grey,),
                                  child: buttoms(context,'رفع الطلب', 15, white, (){})
                              ),),
                              const SizedBox(height: 30,),
                              SizedBox(height: 30.h,),




                            ]),
                        ),),),
                  ],
                ),
              ),),
          );
        }


  Future<http.Response> addGift() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWEwNzYxYWY4NTY4NjUxOTc0NzY5Zjk2OGYyYzlhNGZlMmViODYyOGYyZjU5NzU5NDllOGI3MWJkNjcyZWZlOTA2YWRkMDczZTg5YmFkZjEiLCJpYXQiOjE2NTA0NDk4NzYuMTA3MDk5MDU2MjQzODk2NDg0Mzc1LCJuYmYiOjE2NTA0NDk4NzYuMTA3MTA0MDYzMDM0MDU3NjE3MTg3NSwiZXhwIjoxNjgxOTg1ODc2LjEwMzA4OTA5NDE2MTk4NzMwNDY4NzUsInN1YiI6IjE0Iiwic2NvcGVzIjpbXX0.5nxz23qSWZfll1gGsnC_HZ0-IcD8eTa0e0p9ciKZh_akHwZugs1gU-zjMYOFMUVK34AHPjnpu_lu5QYOPHZuAZpjgPZOWX5iYefAwicq52ZeWSiWbLNlbajR28QKGaUzSn9Y84rwVtxXzAllaJLiwPfhsXK_jQpdUoeWyozMmc5S4_9_Gw72ZeW_VibZ_8CcW05FtKF08yFwRm1mPuuPLUmCSfoVee16FIyvXJBDWEtpjtjzxQUv6ceVw0QQCeLkNeJPPNh3cuAQH1PgEbQm-Tb3kvXg0yu_5flddpNtG5uihcQBQvuOtaSiLZDlJpcG0kUJ2iqGXuog6CosNxq97Wo28ytoM36-zeAQ8JpbpCTi1qn_3RNFr8wZ5C-RvMMq4he2B839qIWDjm0BM7BJSskuUkt9uAFifks8LF3o_USXMQ1mk20_YJxdeaETXwNQgfJ3pZCHUP5UsGmsUsmhiH69Gwm2HTI21k9mV5QGjjWUUihimZO2snbh-pDz7mO_5651j2eVEfi3h3V7HtC0CNGkofH4HPHSTORlEdYlqLvzTqfDos-X05yDSnajPWOldps-ITtzvuYCsstA1X1opTm8siyuDS-SmvnEHFYD53ln_8AfL9I6aCQ9YGNWpNo442zej0qqPxLr_AQhAzfEcqgasRrr32031veKVCd21rA';
    final response = await http.post(
      Uri.parse(
        'https://mobile.celebrityads.net/api/order/gift/add',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
      body: jsonEncode(<String, dynamic>{
        'celebrity_id' : widget.id,
        'date': current.toString(),
        'occasion_id': _selectedTest == null ? ocassionlist.indexOf(0) : ocassionlist.indexOf(_selectedTest),
        'gift_type_id': _selectedTest2 == null ? ocassionlist.indexOf(0) : typelist.indexOf(_selectedTest2),
        'description': desc.text,
        'from': from.text,
        'to': to.text,
        'celebrity_promo_code_id':copun.text,

      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
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
}




// get gift type

Future<GiftType> getGiftType() async {
   final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/gift-types'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
   GiftType g = GiftType.fromJson(jsonDecode(response.body));
    return g;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

// gifting type model

class GiftType {
  bool? success;
  List<DataOcattion>? data;
  MessageOccasion? message;

  GiftType({this.success, this.data, this.message});

  GiftType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataOcattion>[];
      json['data'].forEach((v) {
        data!.add(new DataOcattion.fromJson(v));
      });
    }
    message =
    json['message'] != null ? new MessageOccasion.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? nameEn;

  Data({this.id, this.name, this.nameEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

// occasion type

Future<OccasionType> getOcassionType() async {
  final response = await http.get(
    Uri.parse('https://mobile.celebrityads.net/api/occasions'),);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    OccasionType o= OccasionType.fromJson(jsonDecode(response.body));
    return o;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

// occasion model

class OccasionType {
  bool? success;
  List<DataOcattion>? data;
  MessageOccasion? message;

  OccasionType({this.success, this.data, this.message});

  OccasionType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataOcattion>[];
      json['data'].forEach((v) {
        data!.add(new DataOcattion.fromJson(v));
      });
    }
    message =
    json['message'] != null ? new MessageOccasion.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class DataOcattion {
  int? id;
  String? name;
  String? nameEn;

  DataOcattion({this.id, this.name, this.nameEn});

  DataOcattion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class MessageOccasion {
  String? en;
  String? ar;

  MessageOccasion({this.en, this.ar});

  MessageOccasion.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

// Gift main get

