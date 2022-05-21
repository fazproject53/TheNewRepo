///import section
import 'package:celepraty/Account/Singup.dart';
import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Celebrity/Activity/news/addNews.dart';
import 'package:celepraty/Celebrity/celebrityHomePage.dart';
import 'package:celepraty/Celebrity/setting/celebratyProfile.dart';
import 'package:celepraty/Celebrity/setting/profileInformation.dart';
import 'package:celepraty/MainScreen/main_screen_navigation.dart';
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/introduction_screen/ModelIntro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Celebrity/HomeScreen/celebrity_home_page.dart';
import 'Users/Exploer/Explower.dart';
import 'celebrity/DiscountCodes/discount_codes_main.dart';
import 'introduction_screen/introduction_screen.dart';


void main() => runApp(
         MyApp(),
        // Wrap your app
    );



class MyApp extends StatefulWidget {

   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin {
  Future<IntroData>? futureIntro;

  @override
  void initState() {
 super.initState();
 futureIntro =   getIntroData();
  }

  // i cant hear u
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(413, 763),
      // minTextAdapt: true,
      // splitScreenMode: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'منصة المشاهير',
        theme: ThemeData(fontFamily: "Cairo",
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: purple),),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
          home: Logging()

        // FutureBuilder<IntroData>(
        //   future:futureIntro,
        //   builder: (BuildContext context, AsyncSnapshot<IntroData> snapshot) {
        //     var getData= snapshot.data;
        //     if(snapshot.hasData){
        //       return IntroductionScreen( data:getData?.data);
        //     }
        //     return Center(child:  splash());
        //   },
        // ),

      ),
    );
  }

  Widget splash() {
    return  Scaffold(
        backgroundColor: black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.r,
                backgroundColor: black,
                backgroundImage: Image.asset(
                  'assets/image/log.png',
                ).image,
              ),
              text(context, 'مرحبا بكم في منصة المشاهير', 20, white, align: TextAlign.center)
            ],
          ),
        ),
      );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

