import 'package:card_swiper/card_swiper.dart';
import 'package:celepraty/Account/Singup.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/Users/CreateOrder/buildAdvOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'HomeScreen/celebrity_home_page.dart';
import 'Models.dart';

class celebrityHomePage extends StatefulWidget {
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

int currentIndex = 0;


class _celebrityHomePageState extends State<celebrityHomePage> {
   Future<Section>? futureSections;
   Future<link>? futureLinks;
   Future<header>? futureHeader;
   Future<Partner>? futurePartners;

  List textList = [
    "1الفنان ابيوسف عندنا",
    "2 الفنان ابيوسف عندنا",
    "3 الفنان ابيوسف عندنا"
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      futureSections = fetchSections();
      futurePartners = fetchPartners();
      futureLinks = fetchLinks();
      futureHeader = fetchHeader();
    });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: purple),
          home: Scaffold(
              body: SingleChildScrollView(
                 child: FutureBuilder<Section>(
                    future: futureSections,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<Section> snapshot,
                        ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.connectionState == ConnectionState.active
                          || snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: const Text('Error'));
                        } else if (snapshot.hasData) {
                          return Center(
                            child: Column(
                              children: [
                                for(int i =0; i <snapshot.data!.data!.length; i=i+1 )
                                Column(
                                  children: [
                                    Text(
                                        '${snapshot.data!.data![i].sectionName}',
                                        style: const TextStyle(color: Colors.teal, fontSize: 36)
                                    ),

                                    // FutureBuilder<Partner>(
                                    //   future: futurePartners,
                                    //   builder: (context, snapshot) {
                                    //     return Text(
                                    //         '${snapshot.data!.message!.ar}',
                                    //         style: const TextStyle(color: Colors.teal, fontSize: 36)
                                    //     );
                                    //   },
                                    //
                                    // ),

                                    if('${snapshot.data!.data![i].sectionName}' == 'category')
                                      FutureBuilder<Category>(
                                      future: fetchCategories('${snapshot.data!.data![i].categoryId}'),
                                      builder: (context, snapshot) {
                                        return Text(
                                            '${snapshot.data!.data!.category!.name}',
                                            style: const TextStyle(color: Colors.red, fontSize: 36)
                                        );
                                      },

                                    ),
                                  ],
                                ),


                              ],
                            ),
                          );
                        } else {
                          return Center(child: const Text('Empty data'));
                        }
                      } else {
                        return Center(child: Text('State: ${snapshot.connectionState}'));
                      }
                    },
                  )
              // child: Column(
              //   children: [
//                 SizedBox(
//                     height: 360.h,
//                     width: double.infinity,
//                     child: Stack(
//                       children: [
// //slider image---------------------------------------------------------
//                         imageSlider(),
// //text---------------------------------------------------------
//                         Container(
// //margin: EdgeInsets.only(bottom:25),
//                           decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.center,
//                             colors: [Colors.black26, Colors.transparent],
//                           )),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 40.0.h, horizontal: 15.w),
//                             child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: text(context,
//                                     "${textList[currentIndex]}", 32, white,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         ),
// //icone lang logo--------------------------------------------------------------
//                         heroLogo()
//                       ],
//                     )),
//                 SizedBox(
//                   height: 30.h,
//                 ),
// //3 buttoms-----------------------------------------------
//                 SizedBox(height: 61.h, width: 354.w, child: drowButtom()),
//                 SizedBox(
//                   height: 30.h,
//                 ),
// //comedy----------------------------------------------------------
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "كوميديا", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//
//                 SizedBox(
//                     width: double.infinity,
//                     height: 196.h,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: catogary(
//                           "كوميديا", "مروان بابلو", "assets/image/comp.jpg"),
//                     )),
//                 SizedBox(
//                   height: 15.h,
//                 ),
//
// //sport----------------------------------------------------------
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "رياضة", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//
//                 SizedBox(
//                     width: double.infinity,
//                     height: 196.h,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: catogary(
//                           "رياضة", "مروان بابلو", "assets/image/sport.jpg"),
//                     )),
//                 SizedBox(
//                   height: 15.h,
//                 ),
// //adv panel--------------------------------------------------------
//                 SizedBox(
//                     width: double.infinity, height: 196.h, child: advPanel()),
// //-children---------------------------------------------------------
//                 SizedBox(
//                   height: 15.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "اطفال", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//
//                 SizedBox(
//                     width: double.infinity,
//                     height: 196.h,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: catogary(
//                           "اطفال", "مروان بابلو", "assets/image/child.jpg"),
//                     )),
//                 SizedBox(
//                   height: 15.h,
//                 ),
//
// //سياحة----------------------------------------------------------culture
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "سياحة", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//
//                 SizedBox(
//                     width: double.infinity,
//                     height: 196.h,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: catogary(
//                           "كوميديا", "مروان بابلو", "assets/image/cult.jpg"),
//                     )),
//                 SizedBox(
//                   height: 15.h,
//                 ),
// //adv panel--------------------------------------------------------
//                 SizedBox(
//                     width: double.infinity, height: 196.h, child: advPanel()),
// //-singer---------------------------------------------------------
//                 SizedBox(
//                   height: 15.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "مطربين", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//
//                 SizedBox(
//                     width: double.infinity,
//                     height: 196.h,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.0.h),
//                       child: catogary(
//                           "كوميديا", "مروان بابلو", "assets/image/singer.jpg"),
//                     )),
//                 SizedBox(
//                   height: 15.h,
//                 ),
//
// //-join us---------------------------------------------------------
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: SizedBox(
//                       width: double.infinity,
//                       height: 222.5.h,
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 13.0.w, right: 13.0.w),
//                         child: Row(
//                           children: [
//                             Expanded(
//                                 child: jouinFaums(
//                                     "انضم الان كنجم",
//                                     "اضم الينا الان\nوكن جزء منا",
//                                     "انضم كنجم")),
//                             SizedBox(
//                               width: 32.w,
//                             ),
//                             Expanded(
//                                 child: jouinFaums(
//                                     "انضم الان كمستخدم",
//                                     "اضم الينا الان\nوكن جزء منا",
//                                     "انضم كمستخدم")),
//                           ],
//                         ),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//
// //---------------------------------------------------------------------------------الرعاة الرسميين-
//                 Padding(
//                   padding: EdgeInsets.only(right: 18.w, left: 18.w),
//                   child: Align(
//                       alignment: Alignment.centerRight,
//                       child: text(context, "الرعاة الرسميين", 18, black,
//                           fontWeight: FontWeight.bold)),
//                 ),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//                 SizedBox(
//                     width: double.infinity,
//                     height: 60.h,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16.h, right: 16.h),
//                       child: sponsors(),
//                     )),
//                 ],
//               ),

          )),
        ),
      );

  }
  Future<Section> fetchSections() async {
    final response = await http.get(Uri.parse('http://mobile.celebrityads.net/api/sections'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Section.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }
//------------------------------Slider image-------------------------------------------
  Widget imageSlider() {
    return Swiper(
      itemBuilder: (context, index) {
        final image = sliderImage[index];
        return Image.asset(
          image,
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
      axisDirection: AxisDirection.left,
      itemCount: sliderImage.length,
      pagination: const SwiperPagination(),
      control: SwiperControl(
          color: grey, padding: EdgeInsets.only(left: 20.w, right: 5.w)),
    );
  }

//+ icon + logo ------------------------------------------------------------
  Widget heroLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            child: const Image(image: AssetImage("assets/image/final-logo.png",), fit: BoxFit.cover,)),
      ),
    ]);
  }

//explorer bottom image--------------------------------------------------------------
  Widget drowButtom() {
    return Row(
      children: [
        showButton("صور", "assets/image/cam.jpeg"),
        SizedBox(
          width: 10.w,
        ),
        showButton("اكسبلور", "assets/image/search.jpeg"),
        SizedBox(
          width: 10.w,
        ),
        showButton("بيكسل 1 مليون", "assets/image/star.jpeg"),
      ],
    );
  }

  Widget showButton(String utext, String image) {
    return Expanded(
        child: gradientContainerNoborder(
            105,
            Stack(
              children: [
                //  Align(
                //    alignment: Alignment.topLeft,
                //    child: Image(image: AssetImage(image)),
                //  ),
                Align(
                    alignment: Alignment.center,
                    child: text(context, utext, 14, white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            reids: 20));
  }

//category-------------------------------------------------------------------
  Widget catogary(String catoName, String famusName, String famusImage) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: (){
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
  Widget sponsors() {
    return Image(
        image: const AssetImage("assets/image/ro3a.jpeg"),
        height: 26.h,
        width: 82.w);
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
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SingUp()));
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
}
