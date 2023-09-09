import 'dart:convert';

import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/commonUtil.dart';
import '../commons/const_value.dart';
import 'package:http/http.dart' as http;

import '../helpers/Session.dart';

class HttpHelper {
  static Future<String> fetchPostWithoutLogin(String ulr, Map<String, String> parameters,
      BuildContext context, Function fnWorking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("id_token") ?? "";

    fnWorking(false);

    var _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
    if (_isNetworkAvail) {
      var headers = {'Authorization': 'Bearer $token'};
      String result = "";
      String fullUrl = ConstValue.BaseUrl + ulr;

      var url = Uri.parse(fullUrl);
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(parameters);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, '/login', ModalRoute.withName('/login'));
        fnWorking(true);
        return "";
      }

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        // print("Status OK");
        fnWorking(true);
        return result;
      } else {
        fnWorking(true);
        return result;
        //ToastMessage.showColoredToast("Please select grade!", "WARNING");
      }
    } else {
      // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
      return "";
    }
  }

  static Future<String> fetchPost(String ulr, Map<String, String> parameters,
      BuildContext context, Function fnWorking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("id_token") ?? "";

    fnWorking(false);

    if (token == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
      fnWorking(true);
      return "";
    }

    var _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
    if (_isNetworkAvail) {
      var headers = {'Authorization': 'Bearer $token'};
      String result = "";
      String fullUrl = ConstValue.BaseUrl + ulr;

      var url = Uri.parse(fullUrl);
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(parameters);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
        fnWorking(true);
        return "";
      }

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        // print("Status OK");
        fnWorking(true);
        return result;
      } else {
        fnWorking(true);
        return result;
        //ToastMessage.showColoredToast("Please select grade!", "WARNING");
      }
    } else {
      // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
      return "";
    }
  }

  static Future<String> fetchPostPortal(String ulr, Map<String, String> parameters,
      BuildContext context, Function fnWorking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("id_token") ?? "";

    fnWorking(false);

    if (token == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
      fnWorking(true);
      return "";
    }

    var _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
    if (_isNetworkAvail) {
      var headers = {'Authorization': 'Bearer $token'};
      String result = "";
      String fullUrl = ConstValue.BaseUrlSTDPortal + ulr;

      var url = Uri.parse(fullUrl);
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(parameters);
      // request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
        fnWorking(true);
        return "";
      }

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        // print("Status OK");
        fnWorking(true);
        return result;
      } else {
        fnWorking(true);
        return result;
        //ToastMessage.showColoredToast("Please select grade!", "WARNING");
      }
    } else {
      // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
      return "";
    }
  }

  static Future<String> fetchPostWithUrl(String ulr, Map<String, String> parameters,
      BuildContext context, Function fnWorking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fnWorking(false);

    var _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
    if (_isNetworkAvail) {
      String result = "";
      String fullUrl = ulr;

      var url = Uri.parse(fullUrl);
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(parameters);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
        fnWorking(true);
        return "";
      }

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        // print("Status OK");
        fnWorking(true);
        return result;
      } else {
        fnWorking(true);
        return result;
        //ToastMessage.showColoredToast("Please select grade!", "WARNING");
      }
    } else {
      // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
      return "";
    }
  }


  static Future<String> fetchPostWithoutToken(
      String ulr,
      Map<String, String> parameters,
      BuildContext context,
      Function fnWorking) async {
    String result = "";
    String fullUrl = ConstValue.BaseUrl + ulr;

    var url = Uri.parse(fullUrl);
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(parameters);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 401) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
      fnWorking(true);
      return "";
    }

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      var result = await response.stream.bytesToString();
      // print("Status OK");
      fnWorking(true);
      return result;
    } else {
      fnWorking(true);
      return result;
      //ToastMessage.showColoredToast("Please select grade!", "WARNING");
    }
  }

  static Future refeshValidateToken() async {
    String ulr = "Login/RefeshValidateToken";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("id_token") ?? "";
    if (token == "") {
      return "";
    }
    var headers = {'Authorization': 'Bearer $token'};
    String fullUrl = ConstValue.BaseUrl + ulr;

    var deviceID = await Authentication.getDeviceID();
    Map<String, String> parameters = {'deviceid': deviceID};
    var url = Uri.parse(fullUrl);
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(parameters);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        final json = jsonDecode(result);
        var token = Token.fromJson(json);

        prefs.setString("id_token", token.idToken ?? "");
        prefs.setString("username", token.username ?? "");
        prefs.setString("userTypeID", token.userTypeID ?? "");
        prefs.setString("email", token.email ?? "");
        prefs.setString("fullName", token.fullName ?? "");
        prefs.setString("userType", token.userType ?? "");

        //ToastMessage.showColoredToast(token.idToken ?? "", "WARNING");
      }
    } catch (e, stackTrace) {}
  }

  static Future<String> refeshValidateTokenByBiometrics() async {
    String ulr = "Login/RefeshValidateToken";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token_biometrics") ?? "";
    if (token == "") {
      return "";
    }
    var headers = {'Authorization': 'Bearer $token'};
    String result = "";
    String fullUrl = ConstValue.BaseUrl + ulr;
    Map<String, String> parameters = {};
    var url = Uri.parse(fullUrl);
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(parameters);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        var result = await response.stream.bytesToString();
        final json = jsonDecode(result);
        var token = Token.fromJson(json);

        prefs.setString("id_token", token.idToken ?? "");
        prefs.setString("token_biometrics", token.idToken ?? "");
        prefs.setString("username", token.username ?? "");
        prefs.setString("userTypeID", token.userTypeID ?? "");
        prefs.setString("email", token.email ?? "");
        prefs.setString("fullName", token.fullName ?? "");
        prefs.setString("userType", token.userType ?? "");

        //ToastMessage.showColoredToast(token.idToken ?? "", "WARNING");
        return "OK";
      }
    } catch (e, stackTrace) {
      return "ERROR";
    }

    return "ERROR";
  }
}
