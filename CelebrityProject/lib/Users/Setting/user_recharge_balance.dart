import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../Models/Methods/method.dart';


class UserRechargeBalance extends StatefulWidget {
  const UserRechargeBalance({Key? key}) : super(key: key);

  @override
  _UserRechargeBalanceState createState() => _UserRechargeBalanceState();
}

class _UserRechargeBalanceState extends State<UserRechargeBalance> {

  final TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: drowAppBar('إضافة رصيد', context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                SizedBox(
                  height: 180.h,
                    width: 180.w,
                    child: Lottie.asset('assets/lottie/lf30_editor_4r6m79m8.json')),
                text(context, 'ادخل المبلغ المراد شحنه', 16, black.withOpacity(0.6)),
                SizedBox(height: 20.h,),
                textFieldSmall(context, '', 14, false, amount, (String? value){
                },
                  keyboardType:
                  TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly
                  ],),
                Spacer(),
                padding(
                  22,
                  22,
                  gradientContainerNoborder(getSize(context).width,
                      buttoms(context, 'التالي', 16, white, () {
                        ///Bottom sheet

                      })),
                ),
             SizedBox(height: 60.h,)



              ],
            ),
        ),

      ),
    );
  }
}
