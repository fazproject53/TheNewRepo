import 'dart:convert';

import 'package:celepraty/Celebrity/Activity/ExpandableFab%20.dart';
import 'package:celepraty/Celebrity/Activity/studio/addVideo.dart';
import 'package:celepraty/Celebrity/Activity/studio/addphoto.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../setting/profileInformation.dart';

class Studio extends StatefulWidget {
  _StudioState createState() => _StudioState();
}

class _StudioState extends State<Studio> {
  Future<TheStudio>? getStudio;
  late VideoPlayerController _videoPlayerController;
  bool addp = false;
  bool addv = false;
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  @override
  void initState() {
    getStudio = fetchStudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: addv || addp
            ? null
            : ExpandableFab(
                distance: 80.0,
                children: [
                  ActionButton(
                    onPressed: () => {
                      setState(() {
                        addv = true;
                      })
                    },
                    icon: Icon(
                      vieduoIcon,
                      color: white,
                    ),
                    color: pink,
                  ),
                  ActionButton(
                    onPressed: () => {
                      setState(() {
                        addp = true;
                      })
                    },
                    icon: Icon(
                      imageIcon,
                      color: white,
                    ),
                    color: pink,
                  ),
                ],
              ),
        body: addp
            ? addphoto()
            : addv
                ? addVideo()
                : SingleChildScrollView(
                    child: FutureBuilder<TheStudio>(
                        future: getStudio,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: lodeing(context));
                          } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                              //---------------------------------------------------------------------------
                            } else if (snapshot.hasData) {

                              return Column(
                                children: [
                                  paddingg(
                                    10,
                                    10,
                                    0,
                                    Container(
                                      height: getSize(context).height,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.data!.studio!.length,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context, index) {


                                          return paddingg(
                                            8,
                                            8,
                                            5,
                                            SizedBox(
                                              height: 140.h,
                                              width: 260.w,
                                              child: Card(
                                                elevation: 5,
                                                color: white,
                                                child: paddingg(
                                                  0,
                                                  0,
                                                  8,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          paddingg(
                                                            5,
                                                            10,
                                                            0,
                                                            Container(
                                                              margin: EdgeInsets.only(bottom: 10.h),
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.0),
                                                                child: snapshot.data!.data!.studio![index].type! == "image"? Image.network(
                                                                  snapshot.data!.data!.studio![index].image!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 120.h,
                                                                  width: 100.w,
                                                                ): Container(height: 120.h,
                                                                    width: 100.w,child: VideoPlayer( VideoPlayerController.network(snapshot.data!.data!.studio![index].image!)..initialize())),

                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width:3.w,),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 40.h,
                                                              ),
                                                              Container(
                                                                width: 190.w,
                                                                child: text(
                                                                    context,
                                                                    snapshot.data!.data!.studio![index].description!,
                                                                    14,
                                                                    black),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 20.h,
                                                                left: 15.w),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 30.h,
                                                            ),
                                                            InkWell(
                                                              child: Container(
                                                                child: Icon(
                                                                  removeDiscount,
                                                                  color: white,
                                                                  size: 18,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin: Alignment(
                                                                              0.7,
                                                                              2.0),
                                                                          end: Alignment(
                                                                              -0.69,
                                                                              -1.0),
                                                                          colors: [
                                                                            Color(
                                                                                0xff0ab3d0),
                                                                            Color(
                                                                                0xffe468ca)
                                                                          ],
                                                                          stops: [
                                                                            0.0,
                                                                            1.0
                                                                          ],
                                                                        )),
                                                                height: 28.h,
                                                                width: 32.w,
                                                              ),
                                                              onTap: (){deleteStudio(snapshot.data!.data!.studio![index].id!);},
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(child: Text('Empty data'));
                            }
                          } else {
                            return Center(
                                child:
                                    Text('State: ${snapshot.connectionState}'));
                          }
                        }),
                  ),
      ),
    );
  }
  Future<http.Response> deleteStudio(int id) async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ'
        '6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
    final http.Response response = await http.delete(
      Uri.parse('https://mobile.celebrityads.net/api/celebrity/studio/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token2'
      },
    );

    setState(() {
      getStudio = fetchStudio();
    });
    return response;
  }

}

Future<TheStudio> fetchStudio() async {
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYx'
      'Y2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUs'
      'ImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyF'
      'SV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbA'
      'JexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ6nLby'
      'u1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';
  final response = await http.get(
      Uri.parse('https://mobile.celebrityads.net/api/celebrity/studio'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return TheStudio.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

class TheStudio {
  bool? success;
  Data? data;
  Message? message;

  TheStudio({this.success, this.data, this.message});

  TheStudio.fromJson(Map<String, dynamic> json) {
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
  List<StudioModel>? studio;
  int? status;

  Data({this.studio, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['studio'] != null) {
      studio = <StudioModel>[];
      json['studio'].forEach((v) {
        studio!.add(new StudioModel.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studio != null) {
      data['studio'] = this.studio!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class StudioModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? type;

  StudioModel({this.id, this.title, this.description, this.image, this.type});

  StudioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['type'] = this.type;
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
