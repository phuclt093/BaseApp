import 'package:baseapp/commons/themeValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/img.dart';

class ProgressCircleCenter {
  BuildContext context;

  ProgressCircleCenter(this.context);

  Widget buiddLinearPercentIndicator(double percent) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              lineHeight: 15.0,
              percent: percent,
              animationDuration: 500,
              barRadius: const Radius.circular(10),
              center: Text(
                "${percent * 100}%",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.fontColor,
                    fontSize: 9),
              ),
              backgroundColor: Theme.of(context).colorScheme.skipColor,
              progressColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Align(
      child: Container(
        width: 200,
        //height: 30,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Img.get('logo_white.png'),
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
