import 'package:baseapp/commons/const_value.dart';
import 'package:baseapp/commons/themeValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../data/img.dart';

class ProgressCircleCenter {
  BuildContext context;

  ProgressCircleCenter(this.context);

  // Widget buiddLinearPercentIndicator(double percent) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(15.w),
  //           child: LinearPercentIndicator(
  //             lineHeight: 15.0,
  //             percent: 50.w,
  //             animationDuration: 500,
  //             barRadius: Radius.circular(15.w),
  //             center: Text(
  //               "${percent * 100}%",
  //               style: TextStyle(
  //                   color: Theme.of(context).colorScheme.fontColor,
  //                   fontSize: 9),
  //             ),
  //             backgroundColor: Theme.of(context).colorScheme.skipColor,
  //             progressColor: Theme.of(context).colorScheme.primary,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildLoading() {
    return Align(
      child: Container(
        width: 50.w,
        //height: 30,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Img.get(ConstValue.path_only_logo),
                fit: BoxFit.fill, height: 4.h, width: 10.w),
            SizedBox(
              height: 20.w,
              width: 20.w,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(
                    themeValue.processCircleBarColor),
                strokeWidth: 1.5.w,
              ),
            ),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
