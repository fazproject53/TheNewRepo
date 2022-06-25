import 'dart:convert';

import 'package:celepraty/ModelAPI/ModelsAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

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
  List<Celebrities> oldCelebraty=[];
  ScrollController scrollController = ScrollController();
  bool hasMore = true;
  Future? morCelebraty;
  bool isLoading = false;

  int page = 1;
  @override
  void initState() {
    super.initState();
    morCelebraty = fetchAnotherCategories();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        morCelebraty = fetchAnotherCategories();
      }
    });
  }

  Future refresh() async {
    setState(() {
      hasMore = true;
      isLoading = false;
      page = 1;
    });
    morCelebraty = fetchAnotherCategories();
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
                // color: red,
                child: FutureBuilder(
                    future: morCelebraty,
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: mainLoad(context));
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Center(
                                  child: Text(snapshot.error.toString())));
                          //---------------------------------------------------------------------------
                        } else if (snapshot.hasData) {
                          return SizedBox(
                              child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10.h, left: 10.w, right: 10.w),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            2, //عدد العناصر في كل صف
                                        crossAxisSpacing:
                                            8.r, // المسافات الراسية
                                        childAspectRatio: 0.90.sp, //حجم العناصر
                                        mainAxisSpacing: 11.r //المسافات الافقية

                                        ),
                                controller: scrollController,
                                // scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data!.celebrities!.length +
                                        1,
                                itemBuilder: (context, int index) {
                                  //final item=;
                                  if (index <
                                      snapshot
                                          .data!.data!.celebrities!.length) {
//lode More Data---------------------------------------------------------------------
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
                                                    .celebrities![index]
                                                    .pageUrl!,
                                              ));
                                        },
                                        child: Card(
                                            //elevation: 5,
                                            child: Container(
                                          decoration: decoration(snapshot
                                              .data!
                                              .data!
                                              .celebrities![index]
                                              .image!),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0.w),
                                              child: text(
                                                  context,
                                                  snapshot
                                                              .data!
                                                              .data!
                                                              .celebrities![
                                                                  index]
                                                              .name ==
                                                          ''
                                                      ? "name"
                                                      : snapshot
                                                          .data!
                                                          .data!
                                                          .celebrities![index]
                                                          .name!,
                                                  18,
                                                  white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                            //:Container(color: Colors.green,),
                                            ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                        width: 80.w,
                                        height: 80.h,
                                        child: Center(
                                            child: hasMore
                                                ? CircularProgressIndicator()
                                                : Text('no more item')));
                                  }
//if found more celebraty---------------------------------------------------------------------
                                },
                              ),
                            ),
                          ));
                        } else {
                          return const Center(
                              child: Center(
                                  child: Text('لايوجد مشاهير لعرضهم حاليا')));
                        }
                      } else {
                        return Center(
                            child: Text('State: ${snapshot.connectionState}'));
                      }
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }

//pagination---------------------------------------------------------------------------------
  fetchAnotherCategories() async {
    print('pagNumber befor lode is $page');
    if (isLoading) return;
    isLoading = true;
    final response = await http.get(Uri.parse(
        'http://mobile.celebrityads.net/api/category/celebrities/${widget.categoryId}?page=$page'));
    if (response.statusCode == 200) {
      print('get data from api-----------');
      final body = response.body;
      Category category = Category.fromJson(jsonDecode(body));
      var newItem = category.data!.celebrities!;
      print('leeeeenght ${newItem.length}');
      setState(() {
        page++;
        isLoading = false;
        if (newItem.length < 10) {
          hasMore = false;
        }
        oldCelebraty.addAll(newItem);
      });
      print('oldCelebraty is ${oldCelebraty}');
      return category;
    } else {
      throw Exception('Failed to load more Category');
    }
  }

  @override
  bool get wantKeepAlive => true;
}
