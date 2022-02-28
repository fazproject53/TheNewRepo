import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variabls/varaibles.dart';
import 'package:celepraty/Models/Methods/classes/GradientIcon.dart';
import 'package:celepraty/celebrity/orders/advArea.dart';
import 'package:celepraty/celebrity/orders/gifttingForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:celepraty/celebrity/orders/advForm.dart';
import 'package:card_swiper/card_swiper.dart';

class celebrityHomePage extends StatefulWidget {
  _celebrityHomePageState createState() => _celebrityHomePageState();
}

class _celebrityHomePageState extends State<celebrityHomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: purple),
        home: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 360.h,
                width: double.infinity,
                child: Stack(
                  children: [
//slider image---------------------------------------------------------
                 imageSlider(),
//icone lang logo--------------------------------------------------------------                
              heroLogo()
                ],)
              ),
//image---------------------------------------------------------

              SizedBox(
                  height: 280.h, width: double.infinity, child: Placeholder()),
              SizedBox(
                  height: 280.h, width: double.infinity, child: Placeholder()),

              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:1 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:1 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:1 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
              // Expanded(flex:2 ,child: Placeholder(),),
            ],
          ),
        )),
      ),
    );
  }

  //=================== creating menu for the bottomsheet ===========================
/*
onTap: () {
                        showBottomSheett(context, BottomSheetMenue());
                      }

*/
//-------------bottomSheet-----------------------------------------------------------
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
//------------------------------Slider image-------------------------------------------
  Widget imageSlider() {
     return Swiper(
                  
                  itemBuilder: (context, index) {
                    final image = giftImage[index];
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                    );
                  },
                  onIndexChanged: (int index){
                     print(index);
                  },
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  autoplay: true,
                  axisDirection: AxisDirection.right,
                  itemCount: giftImage.length,
                  pagination: SwiperPagination(),
                  control: SwiperControl(
                      color: grey,
                      padding: EdgeInsets.only(left: 15.w, right: 15.w)),
                );
  }

  heroLogo() {
    Row(
                mainAxisSize: MainAxisSize.min,
                children:[
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20.w,vertical:10.h),
                  child: GradientIcon(Icons.add, 30,gradient() ),
                ),
                GradientIcon(Icons.language, 30,gradient() ),
                Spacer(),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:20.w,vertical:10.h),
                  child: GradientIcon(Icons.language, 30,gradient() ),
                ),
               
              ]),
  }
}
