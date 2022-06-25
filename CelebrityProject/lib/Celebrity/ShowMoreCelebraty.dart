import 'dart:convert';

import 'package:celepraty/ModelAPI/ModelsAPI.dart';
import 'package:flutter/cupertino.dart';
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
  List<Celebrities> oldCelebraty = [];
  ScrollController scrollController = ScrollController();
  bool hasMore = true;
  bool isLoading = false;
  int page = 1;
  @override
  void initState() {
    //print('oldCelebraty.length in inis${oldCelebraty.length}');
    super.initState();
    fetchAnotherCategories();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
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
    //print('oldCelebraty.length in builde${oldCelebraty.length}');
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
//lode More Data---------------------------------------------------------------------
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
            ],
          ),
        ),
      ),
    );
  }

//pagination---------------------------------------------------------------------------------
  fetchAnotherCategories() async {
    print('pagNumber before lode is $page');
    if (isLoading) return;
    isLoading = true;

    final response = await http.get(Uri.parse(
        'http://mobile.celebrityads.net/api/category/celebrities/${widget.categoryId}?page=$page'));
    if (response.statusCode == 200) {
      //print('get data from api-----------');
      final body = response.body;
      Category category = Category.fromJson(jsonDecode(body));
      var newItem = category.data!.celebrities!;
       print('length ${newItem.length}');

      setState(() {
        page++;
        isLoading = false;
        if (newItem.length < 10) {
          hasMore = false;
        }
        oldCelebraty.addAll(newItem);
      });

      return category;
    } else {
      throw Exception('Failed to load more Category');
    }
  }

  @override
  bool get wantKeepAlive => true;
}
