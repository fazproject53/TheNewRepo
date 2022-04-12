///import section
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/introduction_screen/ModelIntro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Celebrity/celebrityHomePage.dart';
import 'MainScreen/main_screen_navigation.dart';
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

class _MyAppState extends State<MyApp> {
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
        home: FutureBuilder<IntroData>(
          future:futureIntro,
          builder: (BuildContext context, AsyncSnapshot<IntroData> snapshot) {
            var getData= snapshot.data;
            if(snapshot.hasData){
              return IntroductionScreen( data:getData?.data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),





      ),
    );
  }
}

