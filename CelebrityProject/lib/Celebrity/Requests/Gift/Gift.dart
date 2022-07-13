import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../Account/LoggingSingUpAPI.dart';
import 'GiftApi.dart';
import 'GiftDetials.dart';

class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> with AutomaticKeepAliveClientMixin {
  String token = '';

  bool isConnectAdvertisingOrder = true;
  bool hasMore = true;
  bool isLoading = false;
  int page = 1;
  int pageCount = 2;
  bool empty = false;
  int? newItemLength;
  List<GiftOrders> oldAdvertisingOrder = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    DatabaseHelper.getToken().then((value) {
      setState(() {
        token = value;
        getGiftingOrders(token);
      });
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset &&
          hasMore == false) {
        print('getNew Data');
        getGiftingOrders(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshRequest,
      child: isConnectAdvertisingOrder == false
          ? Center(
        child: internetConnection(context, reload: () {
          setState(() {
            refreshRequest();
            isConnectAdvertisingOrder = true;
          });
        }),
      ): Padding(
          padding: const EdgeInsets.all(8.0),
          child: empty?noData(context):ListView.builder(
              controller: scrollController,
              itemCount: oldAdvertisingOrder.length + 1,
              itemBuilder: (context, i) {
               if(oldAdvertisingOrder.length > i){
                 return InkWell(
                     onTap: () {
                       goToPagePushRefresh(
                           context,
                           GiftDetials(
                             i: i,
                             price: oldAdvertisingOrder[i].price,
                             description: oldAdvertisingOrder[i].description,
                             advTitle: oldAdvertisingOrder[i].occasion?.name,
                             advType:oldAdvertisingOrder[i].giftType?.name,
                             orderId: oldAdvertisingOrder[i].id,
                             token: token,
                             state: oldAdvertisingOrder[i].status?.id,
                             rejectResonName: oldAdvertisingOrder[i].rejectReson?.name!,
                             rejectResonId: oldAdvertisingOrder[i].rejectReson?.id,
                             from: oldAdvertisingOrder[i].from!,
                             to: oldAdvertisingOrder[i].to!,
                           ),then: (value) {
                         if (clickGift) {
                           setState(() {
                             refreshRequest();
                             clickGift = false;
                           });
                         }
                       });
                     },
                     child: Column(
                       children: [
                         getData(
                             i, oldAdvertisingOrder),
                       ],
                     ));
               }else{
                 return isLoading &&
                     pageCount >= page &&
                     oldAdvertisingOrder.isNotEmpty
                     ? lodeOneData()
                     : const SizedBox();
               }
              })),
    );
  }
  //----------------------------------------------------------------------
  Future refreshRequest() async {
    setState(() {
      hasMore = true;
      isLoading = false;
      page = 1;
      oldAdvertisingOrder.clear();
    });
    getGiftingOrders(token);
  }

  //----------------------------------------------------------------------
  getGiftingOrders(String token) async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    print('pageApi $pageCount pagNumber $page');
    String url =
        "https://mobile.celebrityads.net/api/celebrity/GiftOrders?page=$page";
    if (page == 1) {
      loadingRequestDialogue(context);
    }
    try {
      final respons = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (respons.statusCode == 200) {
        final body = respons.body;
        Gifting advertising = Gifting.fromJson(jsonDecode(body));
        var newItem = advertising.data!.giftOrders!;
        pageCount = advertising.data!.pageCount!;
        print('length ${newItem.length}');
        if (!mounted) return;
        setState(() {
          if (newItem.isNotEmpty) {
            hasMore = newItem.isEmpty;
            oldAdvertisingOrder.addAll(newItem);
            isLoading = false;
            newItemLength = newItem.length;
            if (page == 1) {
              Navigator.pop(context);
            }
            page++;
          } else if (newItem.isEmpty && page == 1) {
            if (page == 1) {
              Navigator.pop(context);
            }
            setState(() {
              empty = true;
            });
          }
        });
        return advertising;
      } else {
       // throw Exception('ggg');
        return Future.error('حدثت مشكله في السيرفر');
      }
    } catch (e) {
      if (page == 1) {
        Navigator.pop(context);
      }
      if (e is SocketException) {
        setState(() {
          isConnectAdvertisingOrder = false;
        });
        return Future.error('SocketException');
      } else if (e is TimeoutException) {
        return Future.error('TimeoutException');
      } else {
        //throw Exception('ggg');
        return Future.error('حدثت مشكله في السيرفر');
      }
    }
  } //refreshRequest-----------------------------------------------------------------

  Widget getData(int i, List<GiftOrders>? giftOrders) {
    return container(
        160,
        double.infinity,
        18,
        18,
        Colors.white,
        Column(
          children: [
//image------------------------------------------------------------------------------------
            Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.h),
                    ),
                  ),

                  child: Stack(
                    children: [
// image------------------------------------------------------------------------------
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r)),
                        child: Image.network(
                          giftOrders![i].occasion!.image!,
                          color: black.withOpacity(0.4),
                          colorBlendMode: BlendMode.darken,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                                child: Lottie.asset('assets/lottie/grey.json',
                                    height: 70.h, width: 70.w));
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sync_problem,
                                    size: 25.r,
                                    color: pink,
                                  ),
                                  text(
                                    context,
                                    '  اضغط لاعادة تحميل الصورة',
                                    12,
                                    Colors.grey,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

//status-----------------------------------------------------------------------------------

                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: text(
                                  context,
                                  giftOrders[i].status!.id == 4
                                      ? 'في انتظار الدفع'
                                      : giftOrders[i].status!.name!,
                                  18,
                                  white,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
// occasion name---------------------------------------------------------------------------------

                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 16.w, bottom: 10.h),
                                  child: text(
                                    context,
                                    "اهداء ل" + giftOrders[i].occasion!.name!,
                                    18,
                                    white,
                                    fontWeight: FontWeight.bold,
                                  ))),
//date and icon---------------------------------------------------------------------------------
                          const Spacer(),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                EdgeInsets.only(right: 16.w, bottom: 10.h),
                                child: text(
                                  context,
                                  giftOrders[i].date!,
                                  18,
                                  white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),

                          SizedBox(width: 10.w),
                        ],
                      )
                    ],
                  )),
            ),



//details-------------------------------------------------------------------------------
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        marginB: 15,
        blur: 5,
        marginT: 5);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
/*
*
*
* */
