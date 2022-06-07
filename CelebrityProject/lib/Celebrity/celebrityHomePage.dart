import 'dart:collection';
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:celepraty/Account/Singup.dart';
import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Users/CreateOrder/buildAdvOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Account/LoggingSingUpAPI.dart';
import '../MainScreen/main_screen_navigation.dart';
import '../ModelAPI/ModelsAPI.dart';
import '../Models/Variables/Variables.dart';
import 'HomeScreen/celebrity_home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class celebrityHomePage extends StatefulWidget {
  const celebrityHomePage({Key? key}) : super(key: key);

  @override
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

int currentIndex = 0;

Map<int, Future<Category>> category = HashMap<int, Future<Category>>();
//Map<int, Future<Category>> newSection = HashMap<int, Future<Category>>();

class _celebrityHomePageState extends State<celebrityHomePage>
    with AutomaticKeepAliveClientMixin {
  DatabaseHelper h = DatabaseHelper();
  Future<Section>? sections;
  Future<link>? futureLinks;
  Future<header>? futureHeader;
  Future<Partner>? futurePartners;
  List<int> pag = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    sections = getSectionsData();
    futureLinks = fetchLinks();
    futureHeader = fetchHeader();
    futurePartners = fetchPartners();
    // Future.delayed(const Duration(seconds: 2),() {
    //   setState(() {
    //     isLoading=false;
    //  });
    // },);
    super.initState();
  }

  Future<Section> getSectionsData() async {
    var getSections = await http
        .get(Uri.parse("http://mobile.celebrityads.net/api/sections"));
    if (getSections.statusCode == 200) {
      final body = getSections.body;

      Section sections = Section.fromJson(jsonDecode(body));

      for (int i = 0; i < sections.data!.length; i++) {
        if (sections.data?[i].sectionName == 'category') {
          setState(() {
            category.putIfAbsent(sections.data![i].categoryId!,
                () => fetchCategories(sections.data![i].categoryId!, 1));
            // pagNumber1++;
          });
        }
      }
      return sections;
    } else {
      throw Exception('Failed to load section');
    }
  }

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
                return Center(child: lodeing());
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  //throw snapshot.error.toString();
                  return Center(child: Text(snapshot.error.toString()));
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
                                  snapshot.data?.data![sectionIndex].title,
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
//new section---------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'new_section')
                              newSection(
                                  snapshot.data?.data![sectionIndex].categoryId,
                                  snapshot.data?.data![sectionIndex].title,
                                  snapshot.data?.data![sectionIndex].active),
//partners--------------------------------------------------------------------------
                            if (snapshot
                                    .data!.data![sectionIndex].sectionName ==
                                'partners')
                              partnersSection(
                                  snapshot.data?.data![sectionIndex].active),
                          ],
                        )
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
        )
        ),
      ),
    );
  }

//"${snapshot.data.data.header[1].title}",------------------------------Slider image-------------------------------------------
  Widget imageSlider(List image, List title) {
    return Swiper(
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              image[index],
            ),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0.h),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: text(context, title[index], 20, white,
                    fontWeight: FontWeight.bold)),
          ),
        );
      },
      onIndexChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },

      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: true,
      //axisDirection: AxisDirection.right,
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
          currentuser == 'user'
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: SizedBox(
                      height: 60.h,
                      width: 60.w,
                      child: InkWell(
                        child: GradientIcon(Icons.add, 40, gradient()),
                        onTap: () {
                          goTopagepush(context, buildAdvOrder());
                        },
                      )),
                )
              : const SizedBox(),
          const Spacer(),
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
                await launch(url.toString(), forceWebView: true);
              },
              child: Align(
                  alignment: Alignment.center,
                  child: text(context, utext, 14, white,
                      fontWeight: FontWeight.bold)),
            ),
            reids: 20));
  }

  BoxDecoration decoration(String famusImage) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      image: DecorationImage(
        image: NetworkImage(famusImage),
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
  Widget sponsors(String image, String link, int index) {
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
              image: NetworkImage(image),
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
                          image: const AssetImage("assets/image/log.png"),
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
  categorySection(int? categoryId, String? title, int? active) {
    return active == 1
        ? FutureBuilder(
            future: category[categoryId],
            builder: ((context, AsyncSnapshot<Category> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(height: 250.h,);
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Center(child: Text(snapshot.error.toString())));
                  //---------------------------------------------------------------------------
                } else if (snapshot.hasData) {
                  return snapshot
                      .data!.data!.celebrities!.isNotEmpty?SizedBox(
                      height: 250.h,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: InkWell(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.0.h, vertical: 4.h),
                              child: text(context, title!, 14, black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data!.celebrities!.length,
                                    itemBuilder: (context, int itemPosition) {
                                      if (snapshot
                                          .data!.data!.celebrities!.isEmpty) {
                                        return const SizedBox();
                                      }
                                      return SizedBox(
                                        width: 180.w,
                                        child: InkWell(
                                          onTap: () {
                                            goTopagepush(
                                                context,
                                                CelebrityHome(
                                                  pageUrl: snapshot
                                                      .data!
                                                      .data!
                                                      .celebrities![
                                                          itemPosition]
                                                      .pageUrl!,
                                                ));
                                          },
                                          child: Card(
                                              elevation: 5,
                                              child: Container(
                                                decoration: decoration(snapshot
                                                    .data!
                                                    .data!
                                                    .celebrities![itemPosition]
                                                    .image!),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0.w),
                                                    child: text(
                                                        context,
                                                        snapshot
                                                                    .data!
                                                                    .data!
                                                                    .celebrities![
                                                                        itemPosition]
                                                                    .name ==
                                                                ''
                                                            ? "name"
                                                            : snapshot
                                                                .data!
                                                                .data!
                                                                .celebrities![
                                                                    itemPosition]
                                                                .name!,
                                                        18,
                                                        white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                              //:Container(color: Colors.green,),
                                              ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        )),
                      )):const SizedBox();
                } else {
                  return const Center(
                      child: Center(child: Text('لايوجد مشاهير لعرضهم حاليا')));
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
    List<String> image = [];
    List<String> titel = [];
    return active == 1
        ? FutureBuilder(
            future: futureHeader,
            builder: ((context, AsyncSnapshot<header> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center();
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
                    titel.add(snapshot.data!.data!.header![headerIndex].title!);
                  }

                  return Column(
                    children: [
                      SizedBox(
                          height: 360.h,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              //slider image----------------------------------------------------
                              imageSlider(image, titel),
                              //icon+ logo------------------------------------------------------
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
                return const Center();
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
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.w),
            child: SizedBox(
                width: double.infinity, height: 196.h, child: advPanel()),
          )
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
        : const SizedBox();
  }
//partnersSection---------------------------------------------------------------------------

  partnersSection(int? active) {
    return active == 1
        ? FutureBuilder(
            future: futurePartners,
            builder: ((context, AsyncSnapshot<Partner> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center();
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
                        textDirection: TextDirection.rtl,
                        child: SizedBox(
                            width: double.infinity,
                            height: 90.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 13.h, right: 13.h),
                              child: ListView.builder(
                                  itemCount:
                                      snapshot.data!.data!.partners!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return sponsors(
                                        snapshot
                                            .data!.data!.partners![i].image!,
                                        snapshot.data!.data!.partners![i].link!,
                                        i);
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

//new section----------------------------------------------------------------------
  newSection(int? secId, String? title, int? active) {
    return active == 1
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: SizedBox(
              width: double.infinity,
              height: 150.h,
              child: gradientContainerNoborder(
                  double.infinity,
                  Center(
                    child: text(context, "اعلان", 18, white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          )
        : const SizedBox();
  }

//lodaing methode---------------------------------------------------------------------------
  Widget lodeing() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: grey!,
              highlightColor: deepwhite,
              enabled: isLoading,
              child: ListView.builder(
                itemBuilder: (_, __) => Column(

                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    shape(360),
                    SizedBox(height: 10.w,),
                    shapeRow(61),
                    SizedBox(height: 10.h),
                    shape(10,width: 90.w),
                    SizedBox(height: 10.h),
                    shapeRow(180),
                    SizedBox(height: 10.h),
                    shape(10,width: 90.w),
                    shapeRow(180),
                    SizedBox(height: 10.h),
                    shape(196),
                    SizedBox(height: 10.h),
                    shape(10,width: 90.w),
                    shapeRow(180),
                    SizedBox(height: 10.h),
                    shape(250),

                  ],
                ),
                itemCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  shape(int j,{double? width}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(0.r))),
          width: width??double.infinity,
          height: j.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.h),
        ),
      ],
    );
  }

  shapeRow(int j) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            width: 354.w,
            height: j.h,
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            width: 354.w,
            height: j.h,
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            width: 354.w,
            height: j.h,
          ),
        )
      ],
    );
  }
}
