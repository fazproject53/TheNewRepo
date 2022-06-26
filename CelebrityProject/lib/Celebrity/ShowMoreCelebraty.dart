import 'dart:convert';

import 'package:celepraty/ModelAPI/ModelsAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/Methods/method.dart';
import '../Models/Variables/Variables.dart';
import 'HomeScreen/celebrity_home_page.dart';

class ShowMoreCelebraty extends StatefulWidget {
  final String? categoryName;
  final int? categoryId;
  const ShowMoreCelebraty(
    this.categoryName,
    this.categoryId,
  );

  @override
  _ShowMoreCelebratyState createState() => _ShowMoreCelebratyState();
}

class _ShowMoreCelebratyState extends State<ShowMoreCelebraty>
    with AutomaticKeepAliveClientMixin {
  List<Celebrities> oldCelebraty = [];
  ScrollController scrollController = ScrollController();
  bool hasMore = true;
  bool isLoading = false;
  int page = 1;
  int pageCount = 2;
  double? high;
  //
  @override
  void initState() {
    high = 0.0;
    super.initState();
    fetchAnotherCategories();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          hasMore == false) {
        // print('getNew Data');
        fetchAnotherCategories();
      }
    });
  }

  Future refresh() async {
    setState(() {
      hasMore = true;
      isLoading = false;
      page = 1;
      oldCelebraty.clear();
    });
    fetchAnotherCategories();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar(widget.categoryName!, context),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                flex:4,
                  child: SizedBox(
                      child: InkWell(
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
                  child: oldCelebraty.isEmpty
                      ? Center(child: mainLoad(context))
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, //عدد العناصر في كل صف
                                  crossAxisSpacing: 8.r, // المسافات الراسية
                                  childAspectRatio: 0.90.sp, //حجم العناصر
                                  mainAxisSpacing: 11.r //المسافات الافقية

                                  ),
                          controller: scrollController,
                          itemCount: oldCelebraty.length,
                          itemBuilder: (context, int index) {
                            return SizedBox(
                              width: 180.w,
                              child: InkWell(
                                onTap: () {
                                  goTopagepush(
                                      context,
                                      CelebrityHome(
                                          pageUrl:
                                              oldCelebraty[index].pageUrl!));
                                },
                                child: Card(
                                    //elevation: 5,
                                    child: Container(
                                  decoration:
                                      decoration(oldCelebraty[index].image!),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0.w),
                                      child: text(context,
                                          oldCelebraty[index].name!, 18, white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                                    //:Container(color: Colors.green,),
                                    ),
                              ),
                            );
                          }),
                ),
              ))),
             ! isLoading && pageCount >= page && oldCelebraty.isNotEmpty
                  ? showLode()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

//pagination---------------------------------------------------------------------------------
  fetchAnotherCategories() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    print('pageApi $pageCount pagNumber $page');
    final response = await http.get(Uri.parse(
        'http://mobile.celebrityads.net/api/category/celebrities/${widget.categoryId}?page=$page'));
    if (response.statusCode == 200) {
      final body = response.body;
      Category category = Category.fromJson(jsonDecode(body));
      var newItem = category.data!.celebrities!;
      pageCount = category.data!.pageCount!;
      print('length ${newItem.length}');
      if (!mounted) return;
      setState(() {
        if (newItem.isNotEmpty) {
          hasMore = newItem.isEmpty;
          oldCelebraty.addAll(newItem);
          isLoading = false;
          page++;
        }
      });

      return category;
    } else {
      throw Exception('Failed to load more Category');
    }
  }

  @override
  bool get wantKeepAlive => true;
//show lode-----------------------------------------------------------
  Widget showLode() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: SizedBox(
        //color: red,
        width: double.infinity,
        height: 70.h,
        child: Shimmer(
            enabled: true,
            gradient:  LinearGradient(
              tileMode: TileMode.mirror,
             // begin: Alignment(0.7, 2.0),
              //end: Alignment(-0.69, -1.0),
              colors: [mainGrey, Colors.white],
              stops: const [0.1, 0.88],
            ),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //عدد العناصر في كل صف
                    crossAxisSpacing: 8.r, // المسافات الراسية
                    childAspectRatio: 0.90.sp, //حجم العناصر
                    mainAxisSpacing: 11.r //المسافات الافقية

                    ),
                itemCount: 2,
                itemBuilder: (context, int index) {
                  return SizedBox(
                    width: 180.w,
                    child: const Card(
                        elevation: 5,
                        ),
                  );
                })),
      ),
    );
  }
}
/*
isLoading && pageCount >= page
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                     // color: red,
                                        width: 140.h,
                                        height: 90.h,
                                        child: Center(child: Lottie.asset('assets/lottie/newWhite.json',fit: BoxFit.cover))),
                                  )
                                : const SizedBox()

* */
