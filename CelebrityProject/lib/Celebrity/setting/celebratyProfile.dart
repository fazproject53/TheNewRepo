import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:celepraty/Celebrity/Activity/activity_screen.dart';
import 'package:celepraty/Celebrity/Balance/balance.dart';
import 'package:celepraty/Celebrity/Calendar/calendar_main.dart';
import 'package:celepraty/Celebrity/Pricing/pricing.dart';
import 'package:celepraty/Celebrity/setting/profileInformation.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/Setting/user_balance.dart';
import 'package:celepraty/celebrity/Brand/create_your_brand.dart';
import 'package:celepraty/celebrity/DiscountCodes/discount_codes_main.dart';
import 'package:celepraty/celebrity/PrivacyPolicy/privacy_policy.dart';
import 'package:celepraty/celebrity/Requests/ReguistMainPage.dart';
import 'package:celepraty/celebrity/TechincalSupport/contact_with_us.dart';
import 'package:celepraty/celebrity/blockList.dart';
import 'package:path/path.dart' as Path;
import 'package:celepraty/invoice/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/Account/logging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

CelebrityInformation? thecelerbrity = CelebrityInformation();

class celebratyProfile extends StatefulWidget {
  _celebratyProfileState createState() => _celebratyProfileState();
}

class _celebratyProfileState extends State<celebratyProfile> {
  Future<CelebrityInformation>? celebrity;

  File? imagefile;
  String? imageurl ;
  final labels = [
    'المعلومات الشخصية',
    'الفوترة',
    'الرصيد',
    'التسعير',
    'الطلبات',
    'علامتك التجارية',
    'اكواد الخصم',
    'جدول المواعيد',
    'التفاعلات',
    'الشروط والاحكام',
    'قائمة الحظر',
    'الدعم',
    'تسجيل الخروج'
  ];
  final List<IconData> icons = [
    nameIcon,
    invoice,
    money,
    price,
    orders,
    store,
    copun,
    scheduale,
    studio,
    pages,
    block,
    chat,
    support,
    logout
  ];
  final List<Widget> page = [
    profileInformaion(),
    invoiceScreen(),
    BalanceMain(),
    PricingMain(),
    RequestMainPage(),
    YourBrandMain(),
    DiscountCodes(),
    CelebrityCalenderMain(),
    ActivityScreen(),
    PrivacyPolicyMain(),
    blockList(),
    ContactWithUsMain(),
    Logging()
  ];
  @override
  void initState() {
    celebrity = fetchCelebrities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarNoIcon("حسابي"),
        body: Center(
          child: SingleChildScrollView(
            child: FutureBuilder<CelebrityInformation>(
              future: celebrity,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: lodeing(context));
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                    //---------------------------------------------------------------------------
                  } else if (snapshot.hasData) {
                    return Column(children: [
                      //======================== profile header ===============================

                      Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            child: padding(
                              8,
                              8,
                              Container(
                                  height: 80.h,
                                  width: 80.w,
                                  child: CircleAvatar(
                                      radius: 48.r,
                                      backgroundImage: Image.network(snapshot.data!.data!.celebrity!.image!).image
                            ),
                              ),
                ),
                            onTap: () {
                              getImage().whenComplete(() => {
                                updateImage().whenComplete(() => {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("تم تعديل الصورة بنجاح"),))
                                })
                              });
                            },
                          ),
                          padding(
                            8,
                            8,
                            text(context, snapshot.data!.data!.celebrity!.name!, 20, black,
                                fontWeight: FontWeight.bold, family: 'Cairo'),
                          ),
                          padding(
                            8,
                            8,
                            text(context, 'الفئة : ' + snapshot.data!.data!.celebrity!.category!.name!, 12, textBlack,
                                family: 'Cairo'),
                          ),
                          paddingg(
                            20,
                            20,
                            3,
                            text(
                                context,
                                snapshot.data!.data!.celebrity!.description!,
                                12,
                                textBlack,
                                family: 'Cairo',
                                align: TextAlign.center),
                          ),
                        ],
                      ), //profile image

                      //=========================== buttons listView =============================

                      SingleChildScrollView(
                        child: Container(
                          child: paddingg(
                            8,
                            0,
                            8,
                            ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return MaterialButton(
                                    onPressed: index == labels.length - 1
                                        ? () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      page[index]),
                                            );
                                          }
                                        : () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      page[index]),
                                            );
                                          },
                                    child: addListViewButton(
                                      labels[index],
                                      icons[index],
                                    ));
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: labels.length,
                            ),
                          ),
                        ),
                      ),

                      //========================== social media icons row =======================================

                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            padding(
                              8,
                              8,
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                    'assets/image/icon- faceboock.png',
                                  )),
                            ),
                            padding(
                              8,
                              8,
                              Container(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/icon- insta.png',
                                ),
                              ),
                            ),
                            padding(
                              8,
                              8,
                              Container(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/icon- snapchat.png',
                                ),
                              ),
                            ),
                            padding(
                              8,
                              8,
                              Container(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/icon- twitter.png',
                                ),
                              ),
                            ),
                          ]),

                      paddingg(
                        8,
                        8,
                        12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              copyRight,
                              size: 14,
                            ),
                            text(
                                context, 'حقوق الطبع والنشر محفوظة', 14, black),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      )
                    ]);
                  } else {
                    return const Center(child: Text('Empty data'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

   updateImage() async {
     String token2 = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQxYjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1MzU1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0rooMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmSGQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yrSF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNac'
        'poAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';


    var stream = new http.ByteStream(DelegatingStream.typed(imagefile!.openRead()));
    // get file length
    var length = await imagefile!.length();

    // string to uri
    var uri = Uri.parse("https://mobile.celebrityads.net/api/celebrity/image/update");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token2"
    };
    // create multipart request
    var request = new http.MultipartRequest( "POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imagefile!.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);


    });
  }
  Future<File?> getImage() async {
    PickedFile? pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final File file = File(pickedFile.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final String fileName = Path.basename(pickedFile.path);
// final String fileExtension = extension(image.path);
    File newImage = await file.copy('$path/$fileName');
    setState(() {
      imagefile = newImage;
      imageurl = imagefile!.path;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
