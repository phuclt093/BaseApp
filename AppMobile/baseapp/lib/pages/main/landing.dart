import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/commons/const_value.dart';
import 'package:baseapp/models/string.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/utils/commonUtil.dart';
import '../../data/img.dart';
import '../../commons/themeValue.dart';
import '../../utils/httpUtil.dart';
import '../../helpers/session.dart';
import '../../helpers/slide_direction.dart';
import '../common/progress_circle_center.dart';
import '../home/home_screen.dart';
import '../auth/login_new_screen.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin {
  bool finishLoading = false;
  String _idToken = "";

  startTime() async {
    var duration = const Duration(milliseconds: 2000);
    return Timer(duration, loadPage);
  }

  @override
  void initState() {
    () async {
       startTime();
      // loadPage();
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
            ),
            Container(
              height: 40,
            ),
            AnimatedOpacity(
              opacity: finishLoading ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: ProgressCircleCenter(context).buildLoading(),
            )
          ]),
    ]));
  }

  void setFinishWorking(bool status) {
    if (mounted) {
      setState(() {
        finishLoading = status;
      });
    }
  }

  loadPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idToken = (prefs.getString('id_token') ?? "");

    if (_idToken != "") {
      // await postCheckExistsTokenValidate(_idToken);

      String ulr = "Login/RefeshValidateToken";
      Map<String, String> parameters = {};

      String resultStr = await HttpHelper.fetchPost(
          ulr, parameters, context, setFinishWorking);

      final json = jsonDecode(resultStr);
      var token = Token.fromJson(json);
      setState(() {
        prefs.setString("id_token", token.idToken ?? "");
        prefs.setString("username", token.username ?? "");
        prefs.setString("userTypeID", token.userTypeID ?? "");
        prefs.setString("email", token.email ?? "");
        prefs.setString("fullName", token.fullName ?? "");
        prefs.setString("userType", token.userType ?? "");

        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => HomeScreenRoute()));
      });
    } else {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => LoginNewScreenRoute()));
    }
  }
}
