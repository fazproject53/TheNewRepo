class CelebrityCalenderMain extends StatelessWidget {
  const CelebrityCalenderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar("جدول المواعيد", context),
        body: const CelebrityCalenderHome(),
      ),
    );
  }
}

///---------------------CelebrityCalenderHome---------------------
class CelebrityCalenderHome extends StatefulWidget {
  const CelebrityCalenderHome({Key? key}) : super(key: key);

  @override
  _CelebrityCalenderHomeState createState() => _CelebrityCalenderHomeState();
}

class _CelebrityCalenderHomeState extends State<CelebrityCalenderHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 23.h, right: 20.w),
                    child: text(context, 'الجدول الخاص بالمواعيد المتفق عليها',
                        17, ligthtBlack),
                  ),
                ),

                ///
                paddingg(
                  10,
                  10,
                  60,
                  ListView.builder(
                    itemCount: calenderList.length,
                    itemBuilder: (context, index) {
                      return paddingg(
                        5,
                        12,
                        10,
                        SizedBox(
                          height: 80.h,
                          child: Card(
                            elevation: 20,
                            color: white,
                            shadowColor: Colors.black38,
                            child: paddingg(
                              0,
                              0,
                              0,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  paddingg(
                                      10,
                                      2,
                                      0,
                                      Row(
                                        children: [
                                          Container(
                                            ///the box of date
                                            alignment: Alignment.center,
                                            height: 70.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.8, 2.0),
                                                  end: Alignment(-0.69, -1.0),
                                                  colors: [
                                                    Color(0xff0ab3d0)
                                                        .withOpacity(0.90),
                                                    Color(0xffe468ca)
                                                        .withOpacity(0.90)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(10.r),
                                                  bottomRight:
                                                  Radius.circular(10.r),
                                                  topRight:
                                                  Radius.circular(10.r),
                                                  topLeft:
                                                  Radius.circular(10.r),
                                                )),

                                            ///Text
                                            child: text(context, calenderList[index].date,
                                                16, white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              text(
                                                  context,
                                                  calenderList[index]
                                                      .typeOfOrder,
                                                  18,
                                                  black.withOpacity(0.9)),
                                              text(
                                                  context,
                                                  calenderList[index].time,
                                                  14,
                                                  grey!.withOpacity(0.9)),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7.w),
                                    child: Row(children: [
                                      InkWell(
                                        child: Icon(
                                          info,
                                          size: 23,
                                          color: black,
                                        ),
                                        onTap: () {
                                          ///When chick the pop card will show with all details

                                        },
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      InkWell(
                                        child: GradientIcon(
                                          share,
                                          25.w,
                                          const LinearGradient(
                                            begin: Alignment(0.7, 2.0),
                                            end: Alignment(-0.69, -1.0),
                                            colors: [
                                              Color(0xff0ab3d0),
                                              Color(0xffe468ca)
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                        onTap: () {
                                          ///Click on it then you can share the details

                                        },
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )

                ///
              ],
            ),
          ),
        ],
      ),
    );
  }
}

