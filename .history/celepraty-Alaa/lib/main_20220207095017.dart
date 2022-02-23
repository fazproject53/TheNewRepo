import 'package:celepraty/Models/Variabls/Variables.dart';
import 'package:celepraty/introduction_screen/src/introduction_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'Account/logging.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // i cant hear u
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(413, 763),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Cairo",
              colorScheme: ColorScheme.fromSwatch().copyWith(primary: pinkLigth),),
            home: MyHomePage()
            //----------------------------------
          ),
      ),
    );
  }
}

