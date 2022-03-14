///import section
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/Users/Setting/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/Methods/classes/GradientIcon.dart';
import '../orders/advArea.dart';
import '../orders/advForm.dart';
import '../orders/gifttingForm.dart';

class CelebrityHomePage extends StatefulWidget {
  const CelebrityHomePage({Key? key}) : super(key: key);

  @override
  _CelebrityHomePageState createState() => _CelebrityHomePageState();
}

class _CelebrityHomePageState extends State<CelebrityHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: CelebrityHome(),
        ));
  }
}

class CelebrityHome extends StatefulWidget {
  const CelebrityHome({Key? key}) : super(key: key);

  @override
  _CelebrityHomeState createState() => _CelebrityHomeState();
}

class _CelebrityHomeState extends State<CelebrityHome> {
  bool isSelect = false;
  int liksCounter = 100;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///Stack for image and there information
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 500.w,
                    height: 400.h,
                    child: Image.asset(
                      'assets/image/featured.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, right: 20.w),
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
                        padding: EdgeInsets.only(top: 165.h, right: 25.w),
                        child: Row(children: [
                          text(context, 'مروان بابلو', 35, white,
                              fontWeight: FontWeight.bold),

                          ///SizedBox
                          SizedBox(
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Icon(
                              verified,
                              color: blue.withOpacity(0.6),
                              size: 25,
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Row(
                          children: [
                            text(context, 'مطرب', 14, white),

                            ///SizedBox
                            SizedBox(
                              width: 5.w,
                            ),
                            CircleAvatar(
                              backgroundImage: Image.asset(
                                'assets/image/Flag_of_Egypt.png',
                              ).image,
                              radius: 10.r,
                            ),

                            ///SizedBox
                            SizedBox(
                              width: 5.w,
                            ),
                            text(context, 'مصر', 14, white),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 12.h, right: 25.w, left: 25.w),
                        child: text(
                            context,
                            'مروان بابلو مطرب يعيش مصر اشتهر مؤخرا باغاني الراب الممزوجة بالطابع واشتهر مؤخرا باغنيتة مفيش مانع التي حققت نجاح كبير جدا',
                            14,
                            white.withOpacity(0.7),
                            align: TextAlign.justify),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 25.w),
                          child: InkWell(
                              onTap: () {
                                goTopagepush(context, userProfile());
                              },
                              child: text(context,
                                  'سياسة التعامل مع مروان بابلو', 14, purple))),

                      ///SizedBox
                      SizedBox(
                        height: 10.h,
                      ),

                      ///Social media icons
                      Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset(
                                    'assets/image/icon- faceboock.png',
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/icon- insta.png',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/icon- snapchat.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/image/icon- twitter.png',
                              ),
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
            height:5.h,
          ),

          ///horizontal listView for news
          SizedBox(
            height: 80.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.r),
                      child: Container(
                        height: 65.h,
                        width: 208.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.r),
                            bottomRight: Radius.circular(50.r),
                            topLeft: Radius.circular(15.r),
                            bottomLeft: Radius.circular(15.r),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment(0.7, 2.0),
                            end: Alignment(-0.69, -1.0),
                            colors: [Color(0xff0ab3d0), Color(0xffe468ca)],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: Image.asset(
                                  'assets/image/celebrityimg.png',
                                ).image,
                                radius: 30.r,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 6.w, left: 10.w, bottom: 7.h,top: 2.h),
                                child: SizedBox(
                                    height: 60.h,
                                    width: 110.w,
                                    child: text(
                                        context,
                                        'لسة عامل حاجة جامدة جدا وفخور بيها بشكل كبير فرحان',
                                        11,
                                        white,
                                    align: TextAlign.justify,
                                    ),
                                  ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ]);
                }),
          ),

          ///SizedBox
          SizedBox(
            height: 5.h,
          ),

          ///Container for celebrity store
          Container(
            margin: EdgeInsets.only(right: 10.w, left: 10.w),
            height: 90.h,
            width: 440.w,
            decoration: BoxDecoration(
                color: black, borderRadius: BorderRadius.circular(7.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(context, 'قم بزيارة المتجر الان', 12, white),
                      text(context, 'المتجر الخاص بمروان بابلو', 16, white),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: gradientContainerNoborder2(
                      90,
                      30,
                      text(context, 'زيارة المتجر', 15, white,
                          align: TextAlign.center)),
                ),
              ],
            ),
          ),

          ///
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: SizedBox(
              height: 350.h,
              width: 400.w,
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //عدد العناصر في كل صف
                  crossAxisSpacing: 15.h, // المسافات الراسية
                  childAspectRatio: 0.90, //حجم العناصر
                  mainAxisSpacing: 5.w,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return viewCard();
                },
              ),
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          padding(
            15,
            15,
            gradientContainerNoborder(
                getSize(context).width,
                buttoms(context, 'اطلب حالا', 20, white, () {
                  showBottomSheett(context, bottomSheetMenue());
                })),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  ///
  Widget bottomSheetMenue() {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 50.h,
        ),
        text(context, 'قم باختيار ما يناسبك من التالي', 22, white),
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
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => gifttingForm()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' طلب اهداء', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    'اطلب اهداءك الان من مشهورك المفضل',
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
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => advForm()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, ' طلب اعلان', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    'اطلب اعلانك الان من مشهورك المفضل  ',
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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[pink, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(50))),
                    height: 40.h,
                    width: 40.h,
                    child:
                        Center(child: Icon(arrow, size: 25.w, color: white))),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => advArea()),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  text(context, 'طلب مساحة اعلانية', 14, white,
                      fontWeight: FontWeight.bold),
                  text(
                    context,
                    '                اطلب مساحتك الاعلانية الان',
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

  Widget viewCard() {
    return Card(
        elevation: 10,
        color: black,
        child: Container(
          decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              image: DecorationImage(
                image: AssetImage(
                  videoImage,
                ),
                fit: BoxFit.fill,
              )),
          child: Column(
            children: [
              ///play video
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: white.withOpacity(0.1),
                    radius: 25.h,
                    child: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Center(
                          child: GradientIcon(
                              playViduo,
                              40,
                              const LinearGradient(
                                begin: Alignment(0.7, 2.0),
                                end: Alignment(-0.69, -1.0),
                                colors: [
                                  Color(0xff0ab3d0),
                                  Color(0xffe468ca)
                                ],
                                stops: [0.0, 1.0],
                              )),
                        ),),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
