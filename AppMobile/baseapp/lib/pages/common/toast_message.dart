import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void showColoredToast(String mgs, String success) {
    if (success == "OK") {
      Fluttertoast.showToast(
          msg: mgs,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    } else if (success == "ERROR") {
      Fluttertoast.showToast(
          msg: mgs,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    } else {
      Fluttertoast.showToast(
          msg: mgs,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    }
  }
}
