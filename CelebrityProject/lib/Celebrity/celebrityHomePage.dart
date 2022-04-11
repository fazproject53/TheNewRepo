import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:celepraty/Account/Singup.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Users/CreateOrder/buildAdvOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../ModelAPI/ModelsAPI.dart';
import '../Models/Variables/Variables.dart';

import 'HomeScreen/celebrity_home_page.dart';

class celebrityHomePage extends StatefulWidget {
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

int currentIndex = 0;
int pagNumber = 1;

class _celebrityHomePageState extends State<celebrityHomePage> {
  Future<Section>? sections;
  Future<link>? futureLinks;
  Future<header>? futureHeader;
  Future<Partner>? futurePartners;
  Future<Category>? futureCategories;
  @override
  void initState() {
    // TODO: implement initState
    sections = getSectionsData();
    futureLinks = fetchLinks();
    futureHeader = fetchHeader();
    futurePartners = fetchPartners();
    futureCategories = fetchCategories(pagNumber);
    super.initState();
  }

//get section---------------------------------------------------------
  Future<Section> getSectionsData() async {
    var getSections = await http
        .get(Uri.parse("http://mobile.celebrityads.net/api/sections"));
    if (getSections.statusCode == 200) {
      Section sections = Section.fromJson(jsonDecode(getSections.body));
      // print((jsonDecode(getSections.body)));
      return sections;
    } else {
      throw Exception('Failed to load activity');
    }
  }

//---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: purple),
        home: Scaffold(
            body: SingleChildScrollView(
          child: FutureBuilder<Section>(
            future: sections,
            builder: (BuildContext context, AsyncSnapshot<Section> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (int sectionIndex = 0;
                          sectionIndex < snapshot.data!.data!.length;
                          sectionIndex++)
                        Column(
                          children: [
//category--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'category')
                              categorySection(
                                  snapshot.data?.data![sectionIndex].categoryId,
                                  snapshot.data?.data![sectionIndex].active),

//header--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'header')
                              headerSection(
                                  snapshot.data?.data![sectionIndex].active),
//links--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'links')
                              linksSection(
                                  snapshot.data?.data![sectionIndex].active),
//Advertising-banner--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'Advertising-banner')
                              advertisingBannerSection(
                                  snapshot.data?.data![sectionIndex].active),
//join-us--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'join-us')
                              joinUsSection(
                                  snapshot.data?.data![sectionIndex].active),
//partners--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'partners')
                              partnersSection(
                                  snapshot.data?.data![sectionIndex].active),
                          ],
                        )

// //3 buttoms-----------------------------------------------
//                       SizedBox(height: 61.h, width: 354.w, child: drowButtom()),
//                       SizedBox(
//                         height: 30.h,
//                       ),
// //comedy----------------------------------------------------------
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "كوميديا", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: catogary("كوميديا", "مروان بابلو",
//                                 "assets/image/comp.jpg"),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//
// //sport----------------------------------------------------------
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "رياضة", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: catogary("رياضة", "مروان بابلو",
//                                 "assets/image/sport.jpg"),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
// //adv panel--------------------------------------------------------
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: advPanel()),
// //-children---------------------------------------------------------
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "اطفال", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: catogary("اطفال", "مروان بابلو",
//                                 "assets/image/child.jpg"),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//
// //سياحة----------------------------------------------------------culture
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "سياحة", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: catogary("كوميديا", "مروان بابلو",
//                                 "assets/image/cult.jpg"),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
// //adv panel--------------------------------------------------------
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: advPanel()),
// //-singer---------------------------------------------------------
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "مطربين", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//
//                       SizedBox(
//                           width: double.infinity,
//                           height: 196.h,
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0.h),
//                             child: catogary("كوميديا", "مروان بابلو",
//                                 "assets/image/singer.jpg"),
//                           )),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//
// //-join us---------------------------------------------------------
//                       Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: SizedBox(
//                             width: double.infinity,
//                             height: 222.5.h,
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 13.0.w, right: 13.0.w),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                       child: jouinFaums(
//                                           "انضم الان كنجم",
//                                           "اضم الينا الان\nوكن جزء منا",
//                                           "انضم كنجم")),
//                                   SizedBox(
//                                     width: 32.w,
//                                   ),
//                                   Expanded(
//                                       child: jouinFaums(
//                                           "انضم الان كمستخدم",
//                                           "اضم الينا الان\nوكن جزء منا",
//                                           "انضم كمستخدم")),
//                                 ],
//                               ),
//                             )),
//                       ),
//                       SizedBox(
//                         height: 24.h,
//                       ),
//
// //---------------------------------------------------------------------------------الرعاة الرسميين-
//                       Padding(
//                         padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: text(context, "الرعاة الرسميين", 18, black,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(
//                         height: 24.h,
//                       ),
//                       SizedBox(
//                           width: double.infinity,
//                           height: 60.h,
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 16.h, right: 16.h),
//                             child: sponsors(),
//                           )),
                    ],
                  );
                } else {
                  return const Center(child: Text('Empty data'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            },
          ),
        )),
      ),
    );
  }

//"${snapshot.data.data.header[1].title}",------------------------------Slider image-------------------------------------------
  Widget imageSlider(List image) {
    return Swiper(
      itemBuilder: (context, index) {
        return Image.network(
          image[index],
          //getImage[index],
          fit: BoxFit.fill,
        );
      },
      onIndexChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: true,
      axisDirection: AxisDirection.right,
      itemCount: image.length,
      pagination: const SwiperPagination(),
      control: SwiperControl(
          color: grey, padding: EdgeInsets.only(left: 20.w, right: 5.w)),
    );
  }

//+ icon + logo ------------------------------------------------------------
  Widget heroLogo() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SizedBox(
                height: 60.h,
                width: 60.w,
                child: InkWell(
                  child: GradientIcon(Icons.add, 40, gradient()),
                  onTap: () {
                    goTopagepush(context, buildAdvOrder());
                  },
                )),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
            child: SizedBox(
                height: 105.h,
                width: 190.w,
                child: const Image(
                  image: AssetImage(
                    "assets/image/final-logo.png",
                  ),
                  fit: BoxFit.cover,
                )),
          ),
        ]);
  }

//explorer bottom image--------------------------------------------------------------
  Widget drowButtom(list, int length) {
    return Row(
      children: [
        showButton(list[2].title, list[2].link),
        SizedBox(
          width: 10.w,
        ),
        showButton(list[1].title, list[1].link),
        SizedBox(
          width: 10.w,
        ),
        showButton(list[0].title, list[2].link),
      ],
    );
  }

  Widget showButton(String utext, String link) {
    return Expanded(
        child: gradientContainerNoborder(
            105,
            InkWell(
              onTap: () async {
                var url = link;
                await launch(url, forceWebView: true);
              },
              child: Align(
                  alignment: Alignment.center,
                  child: text(context, utext, 14, white,
                      fontWeight: FontWeight.bold)),
            ),
            reids: 20));
  }

//category-------------------------------------------------------------------
  Widget catogary(String catoName, String famusName, String famusImage) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          goTopagepush(context, CelebrityHomePage());
        },
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, int itemPosition) {
              return SizedBox(
                width: 160.w,
                height: 196.h,
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: decoration(famusImage),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: text(context, famusName, 18, white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  BoxDecoration decoration(String famusImage) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      image: DecorationImage(
        image: AssetImage(famusImage),
        colorFilter: ColorFilter.mode(black.withOpacity(0.4), BlendMode.darken),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget jouinFaums(String title, String contint, String buttomText) {
    return gradientContainerNoborder(
        184.5,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 26.h,
            ),
            text(context, title, 18, white, fontWeight: FontWeight.bold),
            SizedBox(
              height: 11.h,
            ),
            text(context, contint, 14, white, fontWeight: FontWeight.bold),
            SizedBox(
              height: 26.h,
            ),
            container(
              28.92,
              87,
              0,
              0,
              black_,
              Center(
                  child: text(context, buttomText, 10, white,
                      fontWeight: FontWeight.bold)),
              bottomLeft: 10,
              bottomRight: 10,
              topLeft: 10,
              topRight: 10,
              pL: 10,
              pR: 10,
            ),
            SizedBox(
              height: 44.h,
            ),
          ],
        ));
  }

//-------------------------------------------------------------------------------
  Widget sponsors(String image,String link,int index) {
    return InkWell(
      onTap: () async {
        var url = link;
        await launch(url, forceWebView: true);
      },
      child: Card(
        color: blue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.0.r),
          child: Image(
            fit: BoxFit.cover,
              image: NetworkImage(
                image
              ),
              height: 26.h,
              width: 82.w),
        ),
      ),
    );
  }

  //-------------------------------------------------------------
  Widget advPanel() {
    return gradientContainerNoborder(
        double.infinity,
        Row(
          children: [
            //logo-----------------------------------------
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Transform.rotate(
                  angle: 45,
                  child: container(
                    80,
                    90,
                    0,
                    0,
                    white,
                    Transform.rotate(
                        angle: -45,
                        child: Image(
                          image: AssetImage("assets/image/log.png"),
                          fit: BoxFit.cover,
                          height: 52.h,
                          width: 52.w,
                        )),
                    bottomLeft: 25,
                    bottomRight: 25,
                    topLeft: 25,
                    topRight: 25,
                  ),
                ),
              ),
            ),
//join now+text--------------------------------------------------------------
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 28.w, right: 28.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //text----------------------------------------
                        text(context, "منصة المشاهير", 21, white,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 10.h,
                        ),
                        //buttom----------------------------------------
                        container(
                          34,
                          101,
                          0,
                          0,
                          yallow,
                          Center(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingUp()));
                            },
                            child: text(context, "انضم الان", 17, black,
                                fontWeight: FontWeight.bold),
                          )),
                          bottomLeft: 19,
                          bottomRight: 19,
                          topLeft: 19,
                          topRight: 19,
                          pL: 10,
                          pR: 10,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
        height: 120.h);
  }

//categorySection---------------------------------------------------------------------------
  categorySection(int? categoryId, int? active) {
    return active == 1
        ? FutureBuilder(
            future: futureCategories,
            builder: ((context, AsyncSnapshot<Category> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return const Text("categorySection");
                } else {
                  return const Center(
                      child: Text('لايوجد مشاهير لعرضهم حاليا'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            }))
        : const SizedBox();
  }
//headerSection---------------------------------------------------------------------------

  headerSection(int? active) {
    int headerIndex = 0;
    List<String> image = [];
    return active == 1
        ? FutureBuilder(
            future: futureHeader,
            builder: ((context, AsyncSnapshot<header> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  for (int headerIndex = 0;
                      headerIndex < snapshot.data!.data!.header!.length;
                      headerIndex++) {
                    image.add(snapshot.data!.data!.header![headerIndex].image!);
                  }

                  return Column(
                    children: [
                      SizedBox(
                          height: 360.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              //slider image---------------------------------------------------------
                              imageSlider(image),
                              //text---------------------------------------------------------
                              Container(
                                //margin: EdgeInsets.only(bottom:25),
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                  colors: [Colors.black26, Colors.transparent],
                                )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 40.0.h, horizontal: 15.w),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: text(
                                          context,
                                          "${snapshot.data?.data?.header![headerIndex].title}",
                                          32,
                                          white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              //icon+ logo--------------------------------------------------------------
                              heroLogo()
                            ],
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: Text('لايوجد سلايدر لعرضهم حاليا'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            }))
        : const SizedBox();
  }
//linksSection---------------------------------------------------------------------------

  linksSection(int? active) {
    return active == 1
        ? FutureBuilder(
            future: futureLinks,
            builder: ((context, AsyncSnapshot<link> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                          height: 61.h,
                          width: 354.w,
                          child: drowButtom(snapshot.data?.data?.links,
                              snapshot.data!.data!.links!.length)),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('لايوجد لينك لعرضهم حاليا'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            }))
        : const SizedBox();
  }
//advertisingBannerSection---------------------------------------------------------------------------

  advertisingBannerSection(int? active) {
    return active == 1
        ? SizedBox(width: double.infinity, height: 196.h, child: advPanel())
        // FutureBuilder(
        //     future:f,
        //     builder: ((context, AsyncSnapshot<Category> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else if (snapshot.connectionState == ConnectionState.active ||
        //           snapshot.connectionState == ConnectionState.done) {
        //         if (snapshot.hasError) {
        //           return Center(child: Text(snapshot.error.toString()));
        //           //---------------------------------------------------------------------------
        //         } else if (snapshot.hasData) {
        //           return const Text("categorySection");
        //         } else {
        //           return const Center(child: Text('لايوجد مشاهير لعرضهم حاليا'));
        //         }
        //       } else {
        //         return Center(
        //             child: Text('State: ${snapshot.connectionState}'));
        //       }
        //
        //     }))
        : const SizedBox();
  }
//joinUsSection---------------------------------------------------------------------------

  joinUsSection(int? active) {
    return active == 1
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 222.5.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0.w, right: 13.0.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: jouinFaums("انضم الان كنجم",
                                  "اضم الينا الان\nوكن جزء منا", "انضم كنجم")),
                          SizedBox(
                            width: 32.w,
                          ),
                          Expanded(
                              child: jouinFaums(
                                  "انضم الان كمستخدم",
                                  "اضم الينا الان\nوكن جزء منا",
                                  "انضم كمستخدم")),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ))

        // FutureBuilder(
        //     future: fu,
        //     builder: ((context, AsyncSnapshot<Category> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else if (snapshot.connectionState == ConnectionState.active ||
        //           snapshot.connectionState == ConnectionState.done) {
        //         if (snapshot.hasError) {
        //           return Center(child: Text(snapshot.error.toString()));
        //           //---------------------------------------------------------------------------
        //         } else if (snapshot.hasData) {
        //           return const Text("categorySection");
        //         } else {
        //           return const Center(child: Text('لايوجد مشاهير لعرضهم حاليا'));
        //         }
        //       } else {
        //         return Center(
        //             child: Text('State: ${snapshot.connectionState}'));
        //       }
        //
        //     }))
        : const SizedBox();
  }
//partnersSection---------------------------------------------------------------------------

  partnersSection(int? active) {
    return active == 1
        ? FutureBuilder(
            future: futurePartners,
            builder: ((context, AsyncSnapshot<Partner> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 18.w, left: 18.w),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: text(context, "الرعاة الرسميين", 18, black,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Directionality(
                        textDirection:TextDirection.rtl ,
                        child: SizedBox(
                            width: double.infinity,
                            height: 92.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 13.h, right: 13.h),
                              child: ListView.builder(
                                itemCount: snapshot.data!.data!.partners!.length ,
                                  scrollDirection: Axis.horizontal,

                                  itemBuilder: (context, i) {
                                    return sponsors(
                                      snapshot.data!.data!.partners![i].image!,
                                        snapshot.data!.data!.partners![i].link!,
                                        i
                                    );
                                  }),
                            )),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                      child: Text('لايوجد رعاة رسمين لعرضهم حاليا'));
                }
              } else {
                return Center(
                    child: Text('State: ${snapshot.connectionState}'));
              }
            }))
        : const SizedBox();
  }

//---------------------------------------------------------------------------

}
/*

FutureBuilder<Category>(
                               future: futureCategories,
                               builder: (context,
                                   AsyncSnapshot<Category> catSnapshot) {
                                 return Text(
                                     '${catSnapshot.data?.data!.category!.name}',
                                     style: const TextStyle(
                                         color: Colors.red, fontSize: 36));
                               },
                             )

*/
