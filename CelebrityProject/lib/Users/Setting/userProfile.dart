import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:celepraty/Celebrity/Activity/activity_screen.dart';
import 'package:celepraty/Celebrity/Balance/balance.dart';
import 'package:celepraty/Celebrity/Calendar/calendar_main.dart';
import 'package:celepraty/Celebrity/Pricing/pricing.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/Setting/userInformation.dart';
import 'package:celepraty/Users/Setting/user_balance.dart';
import 'package:celepraty/Users/UserRequests/UserReguistMainPage.dart';
import 'package:celepraty/Users/chat/chatListUser.dart';
import 'package:celepraty/Users/invoice/invoice.dart';
import 'package:celepraty/celebrity/Brand/create_your_brand.dart';
import 'package:celepraty/celebrity/DiscountCodes/discount_codes_main.dart';
import 'package:celepraty/celebrity/PrivacyPolicy/privacy_policy.dart';
import 'package:celepraty/celebrity/Requests/ReguistMainPage.dart';
import 'package:celepraty/celebrity/TechincalSupport/contact_with_us.dart';
import 'package:celepraty/celebrity/blockList.dart';
import 'package:path/path.dart' as Path;
import 'package:celepraty/celebrity/setting/profileInformation.dart';
import 'package:celepraty/invoice/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/Account/logging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../Account/LoggingSingUpAPI.dart';

class userProfile extends StatefulWidget {
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile>
    with AutomaticKeepAliveClientMixin {
  Future<UserProfile>? getUsers;
  String userToken ="";
  List<Data>? data;
  final labels = [
    'المعلومات الشخصية',
    'الفوترة',
    'الرصيد',
    'الطلبات',
    'الدعم',
    'تسجيل الخروج'
  ];
  final List<IconData> icons = [
    nameIcon,
    invoice,
    money,
    orders,
    support,
    logout
  ];
  final List<Widget> page = [
    userInformation(),
    Invoice(),
    const UserBalance(),
    UserRequestMainPage(),
    const ContactWithUsMain(),
    const Logging()
  ];

  File? userImage;
  @override
  void initState() {
    DatabaseHelper.getToken().then((value) {
      setState(() {
        userToken = value;
        getUsers = fetchUsers(userToken);
      });
    });


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
            child: FutureBuilder<UserProfile>(
              future: getUsers,
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
                            height: 30.h,
                          ),
                          InkWell(
                            child: padding(
                              8,
                              8,
                              Container(
                                  height: 56.h,
                                  width: 56.w,
                                  child: CircleAvatar(
                                      radius: 48.r,
                                      backgroundImage: userImage == null
                                          ? Image.network(
                                                  snapshot.data!.data!.user!.image!)
                                              .image
                                          : Image.file(userImage!).image)),
                            ),
                            onTap: () {
                              getImage().whenComplete(() => {
                                updateImageUser(userToken).whenComplete(() => {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("تم تعديل الصورة بنجاح"),))
                                })
                              });
                            },
                          ),
                          padding(
                            8,
                            8,
                            text(context, snapshot.data!.data!.user!.name!, 20, black,
                                fontWeight: FontWeight.bold, family: 'Cairo'),
                          ),
                        ],
                      ), //profile image

                      //=========================== buttons listView =============================

                      SingleChildScrollView(
                        child: Container(
                          child: paddingg(
                            8,
                            0,
                            25,
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

  updateImageUser(String token) async {

    var stream = new http.ByteStream(DelegatingStream.typed(userImage!.openRead()));
    // get file length
    var length = await userImage!.length();

    // string to uri
    var uri = Uri.parse("https://mobile.celebrityads.net/api/user/image/update");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    // create multipart request
    var request = new http.MultipartRequest( "POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(userImage!.path));

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
      userImage = newImage;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


Future<UserProfile> fetchUsers(String token) async {
  final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/user/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

class UserProfile {
  bool? success;
  Data? data;
  Message? message;

  UserProfile({this.success, this.data, this.message});

  UserProfile.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  int? status;

  Data({this.user, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? name;
  String? image;
  String? email;
  String? phonenumber;
  Country? country;
  City? city;
  String? type;

  User(
      {this.id,
      this.username,
      this.name,
      this.image,
      this.email,
      this.phonenumber,
      this.country,
      this.city,
      this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Country {
  String? name;
  String? nameEn;
  String? flag;

  Country({this.name, this.nameEn, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['flag'] = this.flag;
    return data;
  }
}

class City {
  String? name;
  String? nameEn;

  City({this.name, this.nameEn});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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


