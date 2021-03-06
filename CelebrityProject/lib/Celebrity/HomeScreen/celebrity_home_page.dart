///import section
import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/Exploer/viewData.dart';
import 'package:celepraty/Users/Exploer/viewDataImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../ModelAPI/CelebrityScreenAPI.dart';
import '../../Models/Methods/classes/GradientIcon.dart';

import '../orders/advArea.dart';
import '../orders/advForm.dart';
import '../orders/gifttingForm.dart';
import 'package:http/http.dart' as http;

class CelebrityHome extends StatefulWidget {
  final String? pageUrl;
  const CelebrityHome({Key? key, this.pageUrl}) : super(key: key);

  @override
  _CelebrityHomeState createState() => _CelebrityHomeState();
}

class _CelebrityHomeState extends State<CelebrityHome>
    with AutomaticKeepAliveClientMixin
{
  bool isSelect = false;
  Future<introModel>? celebrityHome;

  ///list of string to store the advertising area images
  List<String> advImage = [];

  ///Pagination Variable Section

  bool isHasMore = true;
  bool isLoading = false; ///Waiting Process
  bool empty = false;

  int basicPage = 1;
  int pageCount = 2;
  int? newItemLength;

  List<News> oldNews = []; ///To Store all news
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    celebrityHome = getSectionsData(widget.pageUrl!);
    getNews();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset
      &&
      isHasMore == false){
        getNews();
      }
    });
    super.initState();
  }

  Future<introModel> getSectionsData(String pageUrl) async {
    final response = await http.get(
        Uri.parse(
            'https://mobile.celebrityads.net/api/celebrity-page/$pageUrl'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);

      return introModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder<introModel>(
                future: celebrityHome,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: mainLoad(context));
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      //throw snapshot.error.toString();
                      return Center(child: Text(snapshot.error.toString()));
                      //---------------------------------------------------------------------------
                    } else if (snapshot.hasData) {
                      ///get the adv image from API and store it inside th list

                      for (int i = 0;
                          i < snapshot.data!.data!.adSpaceOrders!.length;
                          i++) {
                        advImage.contains(
                                snapshot.data!.data!.adSpaceOrders![i].image!)
                            ? null
                            : advImage.add(
                                snapshot.data!.data!.adSpaceOrders![i].image!);
                      }
                      return Column(
                        children: [
                          ///Stack for image and there information
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 500.w,
                                    height: 400.h,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data!.data!.celebrity!.image!,
                                            ),
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.black54,
                                                BlendMode.darken))),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 30.h, right: 20.w),
                                    child: Row(
                                      children: [
                                        ///back icon to the main screen
                                        IconButton(
                                          icon: const Icon(Icons.arrow_back_ios),
                                          color: white,
                                          iconSize: 30,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 165.h, right: 25.w),
                                        child: Row(children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 5.h),
                                            child: Icon(
                                              verified,
                                              color: blue.withOpacity(0.6),
                                              size: 27,
                                            ),
                                          ),
                                          ///SizedBox
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          text(
                                              context,
                                              snapshot
                                                  .data!.data!.celebrity!.name!,
                                              35,
                                              white,
                                              fontWeight: FontWeight.bold),
                                        ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 25.w),
                                        child: Row(
                                          children: [
                                            text(
                                                context,
                                                snapshot.data!.data!.celebrity!
                                                    .category!.name!,
                                                14,
                                                white),

                                            ///SizedBox
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: Image.network(
                                                      snapshot
                                                          .data!
                                                          .data!
                                                          .celebrity!
                                                          .country!
                                                          .flag!)
                                                  .image,
                                              radius: 10.r,
                                            ),

                                            ///SizedBox
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            text(
                                                context,
                                                snapshot.data!.data!.celebrity!
                                                    .country!.name!,
                                                14,
                                                white),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 12.h, right: 25.w, left: 25.w),
                                        child: text(
                                            context,
                                            snapshot.data!.data!.celebrity!
                                                .description!,
                                            14,
                                            white.withOpacity(0.7),
                                            align: TextAlign.justify),
                                      ),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(right: 25.w),
                                          child: InkWell(
                                              onTap: () {
                                                showDialogFunc(
                                                    context,
                                                    '',
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .advertisingPolicy!,
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .giftingPolicy!,
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .adSpacePolicy!);
                                              },
                                              child: text(
                                                  context,
                                                  '?????????? ?????????????? ???? ' +
                                                      snapshot.data!.data!
                                                          .celebrity!.name!,
                                                  16,
                                                  purple))),

                                      ///SizedBox
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      ///Social media icons
                                      Padding(
                                        padding: EdgeInsets.only(right: 25.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: InkWell(
                                                  child: Image.asset(
                                                    'assets/image/icon- faceboock.png',
                                                  ),
                                                  onTap: () async {
                                                    var url = snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .facebook!;
                                                    if (url == "") {
                                                      ///Do nothing
                                                    } else {
                                                      await launch(url,
                                                          forceWebView: true);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: InkWell(
                                                    child: Image.asset(
                                                      'assets/image/icon- insta.png',
                                                    ),
                                                    onTap: () async {
                                                      var url = snapshot
                                                          .data!
                                                          .data!
                                                          .celebrity!
                                                          .instagram!;
                                                      if (url == "") {
                                                        ///Do nothing
                                                      } else {
                                                        await launch(url,
                                                            forceWebView: true);
                                                      }
                                                    }),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: InkWell(
                                                    child: Image.asset(
                                                      'assets/image/icon- snapchat.png',
                                                    ),
                                                    onTap: () async {
                                                      var url = snapshot
                                                          .data!
                                                          .data!
                                                          .celebrity!
                                                          .snapchat!;
                                                      if (url == "") {
                                                        ///Do nothing
                                                      } else {
                                                        await launch(url,
                                                            forceWebView: true);
                                                      }
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: InkWell(
                                                  child: Image.asset(
                                                    'assets/image/icon- twitter.png',
                                                  ),
                                                  onTap: () async {
                                                    var url = snapshot
                                                        .data!
                                                        .data!
                                                        .celebrity!
                                                        .twitter!;
                                                    if (url == "") {
                                                      ///Do nothing
                                                    } else {
                                                      await launch(url,
                                                          forceWebView: true);
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),

                          ///SizedBox
                          SizedBox(
                            height: 5.h,
                          ),

                          ///horizontal listView for news
                          Visibility(
                            visible: oldNews.isEmpty ? true : false,
                            child: SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: oldNews.length + 1,
                                  itemBuilder: (context, index) {
                                  if(oldNews.length > index){
                                    return Row(children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Container(
                                          height: 70.h,
                                          width: 208.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50.r),
                                              bottomRight:
                                              Radius.circular(50.r),
                                              topLeft: Radius.circular(15.r),
                                              bottomLeft: Radius.circular(15.r),
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment(0.7, 2.0),
                                              end: Alignment(-0.69, -1.0),
                                              colors: [
                                                Color(0xff0ab3d0),
                                                Color(0xffe468ca)
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(right: 8.w),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage:
                                                  Image.network(snapshot
                                                      .data!
                                                      .data!
                                                      .celebrity!
                                                      .image!)
                                                      .image,
                                                  radius: 30.r,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 110.w,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      text(
                                                        context,
                                                        snapshot
                                                            .data!
                                                            .data!
                                                            .news![index]
                                                            .description!,
                                                        11,
                                                        white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }else{
                                    return isLoading && pageCount >= basicPage && oldNews.isNotEmpty ? lodeOneData() : SizedBox();
                                  }

                                  }),
                            ),
                          ),

                          ///SizedBox
                          SizedBox(
                            height: 5.h,
                          ),

                          Visibility(
                            visible: advImage.isEmpty ? false : true,
                            child: Container(
                                margin: EdgeInsets.only(right: 10.w, left: 10.w),
                                height: 150.h,
                                decoration: BoxDecoration(
                                    color: black,
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: imageSlider(advImage)),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          ///Container for celebrity store
                          Container(
                            margin: EdgeInsets.only(right: 10.w, left: 10.w),
                            height: 90.h,
                            width: 440.w,
                            decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      text(context, '???? ???????????? ???????????? ????????', 12,
                                          white),
                                      text(context, '???????????? ?????????? ???????????? ??????????',
                                          16, white),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: InkWell(
                                    child: gradientContainerNoborder2(
                                        90,
                                        30,
                                        text(context, '?????????? ????????????', 15, white,
                                            align: TextAlign.center)),
                                    onTap: () {
                                      snapshot.data!.data!.celebrity!.brand!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Visibility(
                            visible: snapshot.data!.data!.studio!.isEmpty
                                ? false
                                : true,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w, left: 10.w),
                              child: SizedBox(
                                height: 350.h,
                                width: 400.w,
                                child: GridView.builder(
                                  itemCount:
                                      snapshot.data!.data!.studio!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, //?????? ?????????????? ???? ???? ????
                                    crossAxisSpacing: 15.h, // ???????????????? ??????????????
                                    childAspectRatio: 0.90, //?????? ??????????????
                                    mainAxisSpacing: 5.w,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    ///play the celebrity video
                                    return Card(
                                      elevation: 10,
                                      child: Stack(
                                        children: [
                                          snapshot.data!.data!.studio![i]
                                                      .type! ==
                                                  "image"
                                              ? InkWell(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4.r)),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              snapshot
                                                                  .data!
                                                                  .data!
                                                                  .studio![i]
                                                                  .image!,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ))),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ImageData(
                                                                      image: snapshot
                                                                          .data!
                                                                          .data!
                                                                          .studio![
                                                                              i]
                                                                          .image!,
                                                                    )));
                                                  },
                                                )
                                              : Stack(
                                                  children: [
                                                    ///Video
                                                    VideoPlayer(
                                                        VideoPlayerController
                                                            .network(snapshot
                                                                .data!
                                                                .data!
                                                                .studio![i]
                                                                .image!)
                                                          ..initialize()),

                                                    ///Play Icon
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ///play video
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10.h,
                                                                    right:
                                                                        55.w),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            viewData(
                                                                              video: snapshot.data!.data!.studio![i].image!,
                                                                            )));
                                                                print('Tap it');
                                                              },
                                                              icon: GradientIcon(
                                                                  playViduo,
                                                                  40.sp,
                                                                  const LinearGradient(
                                                                    begin:
                                                                        Alignment(
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
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10.h,
                          ),

                          padding(
                            15,
                            15,
                            gradientContainerNoborder(
                                getSize(context).width,
                                buttoms(context, '???????? ????????', 20, white, () {
                                  showBottomSheett(
                                      context,
                                      bottomSheetMenu(
                                          snapshot.data!.data!.celebrity!.id!
                                              .toString(),
                                          snapshot
                                              .data!.data!.celebrity!.image!,
                                          snapshot.data!.data!.celebrity!.name!
                                              .toString()));
                                })),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No info to show!!'));
                    }
                  } else {
                    return Center(
                        child: Text('State: ${snapshot.connectionState}'));
                  }
                })),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  ///image slider
  Widget imageSlider(List adImage) {
    return Swiper(
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: true,
      itemCount: adImage.length,
      pagination: const SwiperPagination(),
      control:
          SwiperControl(color: white, padding: EdgeInsets.only(right: 8.w)),
      itemBuilder: (context, index) {
        return Container(
          height: 90.h,
          width: 440.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              image: DecorationImage(
                image: NetworkImage(
                  adImage[index],
                ),
                fit: BoxFit.cover,
              )),
        );
      },
      onIndexChanged: (int index) {
        setState(() {
          //currentIndex = index;
        });
      },
    );
  }

  ///order from the celebrity
  Widget bottomSheetMenu(String id, image, name) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 50.h,
        ),
        text(context, '???? ?????????????? ???? ???????????? ???? ????????????', 22, white),
        SizedBox(
          height: 30.h,
        ),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Padding(
                          padding:  EdgeInsets.only(top: 2.h, left: 10.w),
                          child: Icon(arrow, size: 25.w, color: white),
                        )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => gifttingForm(
                              id: id,
                              image: image,
                              name: name,
                            )),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' ?????? ??????????', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    '???????? ???????????? ???????? ???? ???????????? ????????????',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          copun,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
        const Divider(
          color: darkWhite,
        ),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(70))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Padding(
                          padding: EdgeInsets.only(top: 2.h, left: 10.w),
                          child: Icon(arrow, size: 25.w, color: white),
                        )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => advForm(
                              id: id,
                              image: image,
                              name: name,
                            )),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' ?????? ??????????', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    '???????? ???????????? ???????? ???? ???????????? ????????????',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10))),
                  alignment: Alignment.centerRight,
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          ad,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
        const Divider(color: darkWhite),
        SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.all(Radius.circular(50.r))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Padding(
                          padding:EdgeInsets.only(top: 2.h, left: 10.w),
                          child: Icon(arrow, size: 25.w, color: white),
                        )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => advArea(
                              id: id,
                            )),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, '?????? ?????????? ??????????????', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    '                ???????? ???????????? ?????????????????? ????????',
                    10,
                    darkWhite,
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: border),
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  alignment: Alignment.centerRight,
                  height: 70.h,
                  width: 70.w,
                  child: Center(
                      child: GradientIcon(
                          adArea,
                          40.0.w,
                          const LinearGradient(
                              colors: <Color>[pink, blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight))))
            ],
          ),
        ),
      ]),
    );
  }

  ///privacy policy for the celebrity
  showDialogFunc(context, title, adDes, giftDes, areaDes) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: white,
              ),
              padding: EdgeInsets.only(top: 15.h, right: 20.w, left: 20.w),
              height: 380.h,
              width: 380.w,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection: TextDirection.rtl,
                  children: [
                    ///Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///text
                        text(context, '???????????? ?????????? ??????????????', 14, grey!),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    ///Adv Title
                    text(context, '?????????? ??????????????', 16, black,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5.h,
                    ),

                    ///Adv Details
                    text(
                      context,
                      adDes,
                      14,
                      ligthtBlack,
                    ),

                    ///---------------------
                    SizedBox(
                      height: 15.h,
                    ),

                    ///---------------------

                    ///Gifting Title
                    text(context, '?????????? ??????????????', 16, black,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5.h,
                    ),

                    ///Gifting Details
                    text(
                      context,
                      giftDes,
                      14,
                      ligthtBlack,
                    ),

                    ///---------------------
                    SizedBox(
                      height: 15.h,
                    ),

                    ///---------------------

                    ///Area Title
                    text(context, '?????????? ?????????????? ??????????????????', 16, black,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5.h,
                    ),

                    ///Area Details
                    text(
                      context,
                      areaDes,
                      14,
                      ligthtBlack,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///Pagination of news
  getNews() async {
    if(isLoading){
      return ;
    }
    setState(() {
      isLoading = true;
    });

    ///page url check
    String url = "";
    if(basicPage == 1){
      loadingRequestDialogue(context);
    }

    try{
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      });
      if(response.statusCode == 20){
        final body = response.body;
        introModel newsPagination = introModel.fromJson(jsonDecode(body));

        var newNews = newsPagination.data!.news!;
        pageCount = newsPagination.data!.newsPageCount!;
        if (!mounted) return;
print('boooooodyyyyy: $body');
        setState(() {
          if(newNews.isNotEmpty){
            isHasMore = newNews.isEmpty;
            oldNews.addAll(newNews);

            isLoading = false;
            newItemLength = newNews.length;
            if(basicPage == 1){
              Navigator.pop(context);
            }
            basicPage++;
          }else if(newNews.isEmpty && basicPage == 1){
            if(basicPage == 1){
              Navigator.pop(context);
            }
            setState(() {
              empty = true;
            });
          }
        });
        return newsPagination;
      }else{
        return Future.error('error');
      }
    }catch (error){
      if (basicPage == 1) {
        Navigator.pop(context);
      }
    }
  }
}


