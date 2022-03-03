import 'package:celepraty/Account/logging.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:celepraty/introduction_screen/src/introduction_screen.dart';
import 'package:celepraty/introduction_screen/src/model/page_decoration.dart';
import 'package:celepraty/introduction_screen/src/model/page_view_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  Widget _buildFullscreenImage(String assetName) {
    return Image.asset(
      'assets/image/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = const TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding:  EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: pink,
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
          ),
        ),
      ),
      //------------------------------------------
      //Pages Section
      pages: [
        PageViewModel(
            title: "تواصل بالفيديو",
            body: "يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو, يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو",
            image: _buildFullscreenImage("intro1.png"),
            decoration: pageDecoration.copyWith(
              titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo'),
              bodyTextStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.white70,
                  fontFamily: 'Cairo'
              ),
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
            )),
        PageViewModel(
            title: "نجمك المفضل عندنا",
            body: "يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو, يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو",
            image: _buildFullscreenImage("intro2.png"),
            decoration: pageDecoration.copyWith(
              titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo'),
              bodyTextStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.white70,
                  fontFamily: 'Cairo'
              ),
              contentMargin:  const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
            )),
        PageViewModel(
            title: "المطربين متواجدين",
            body: "يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو, يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو",
            image: _buildFullscreenImage("intro3.png"),
            decoration: pageDecoration.copyWith(
              titleTextStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo'),
              bodyTextStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.white70,
                  fontFamily: 'Cairo'
              ),
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
            )),
        PageViewModel(
            title: "ابدأ تجربتك الان",
            body: "يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو, يمكنك الان التواصل مع المشاهير والمؤثرين عن طريق الفيديو",
            image: _buildFullscreenImage("intro4.png"),
            decoration: pageDecoration.copyWith(
              titleTextStyle: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo'),
              bodyTextStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white70,
                  fontFamily: 'Cairo'
              ),
              contentMargin: EdgeInsets.symmetric(horizontal: 16.w),
              fullScreen: true,
              bodyFlex: 2,
              imageFlex: 3,
            )),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,

      skip: const Text(
        'تخطي',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      done: const Text('بدء', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin:  EdgeInsets.all(16.w),
      controlsPadding: kIsWeb
          ?  EdgeInsets.all(12.0.w)
          : EdgeInsets.fromLTRB(8.0.w, 4.0.h, 8.0.h, 4.0.w),
      dotsDecorator: DotsDecorator(
        size: Size(10.0.w, 10.0.h),
        color: const Color(0xFFBDBDBD),
        activeSize: Size(22.0.w, 10.0.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------
//Main Screen
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logging(),
    );
  }
}
