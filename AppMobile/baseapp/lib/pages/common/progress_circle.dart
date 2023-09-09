import 'package:baseapp/helpers/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/img.dart';

class ProgressCircle {
  BuildContext context;
  double height = 15.0;

  ProgressCircle(this.context, this.height);

  Widget buiddLinearPercentIndicator(double percent) {
    return
      Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, top: 0, right: 0, bottom: 0),
                child: LinearPercentIndicator(
                  lineHeight: height,
                  percent: percent,
                  animationDuration: 500,
                  barRadius: const Radius.circular(10),
                  center: Text(
                    "${percent * 100}%",
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .fontColor, fontSize: 9),
                  ),
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .skipColor,
                  progressColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              ),
            ],
          )
      );
  }

  Widget buildLoading() {
    // return Align(
    //   child: Container(
    //     width: 200,
    //     height: 30,
    //     alignment: Alignment.center,
    //     child: const WidgetDotBounce(
    //         color: Color.fromARGB(255, 218, 86, 245), size: 20.0),
    //   ),
    //   alignment: Alignment.center,
    // );

    return Align(
      child: Container(
        width: 200,
        //height: 30,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // CircleAvatar(
            //   backgroundImage:
            //       ExactAssetImage(Img.get('logo_only.png'), scale: 0.05),
            //   // Optional as per your use case
            //   // minRadius: 30,
            //   // maxRadius: 70,
            //   radius: 15,
            //   backgroundColor: Colors.white,
            // ),
            Image.asset(Img.get('logo_only.png'),
                fit: BoxFit.fill, height: 20, width: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 238, 44, 53)),
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
