import 'package:baseapp/commons/themeValue.dart';
import 'package:baseapp/pages/auth/authentication.dart';
import 'package:baseapp/pages/common/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/localizationUtil.dart';

import '../../helpers/Session.dart';

class AuthenticateBiometricsRoute extends StatefulWidget {
  AuthenticateBiometricsRoute({Key? key, required this.token})
      : super(key: key);

  late String token;

  @override
  // ignore: no_logic_in_create_state
  AuthenticateBiometricsRouteState createState() =>
      AuthenticateBiometricsRouteState(key: key, token: token);
}

class AuthenticateBiometricsRouteState
    extends State<AuthenticateBiometricsRoute> {
  bool finishLoading = false;
  String remotePDFpath = "";
  bool _isLoading = false;

  bool showClear = false;
  late LocalAuthentication localAuthentication = LocalAuthentication();

  late String token;
  final TextEditingController inputController = TextEditingController();
  bool isDisabled = false;

  AuthenticateBiometricsRouteState({
    Key? key,
    required this.token,
  });

  @override
  void initState() {
    setFinishWorking(false);

    super.initState();
    getAuthenSetup();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        finishLoading = true;
      });
    });
  }

  void setFinishWorking(bool status) {
    if (mounted) {
      setState(() {
        finishLoading = status;
      });
    }
  }

  void getAuthenSetup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenBiometrics = prefs.getString("token_biometrics") ?? "";
    String isEnableLogin = prefs.getString("is_enable_login") ?? "no";
    setState(() {
      isDisabled = isEnableLogin == "yes" ? true : false;
    });
  }

  void enableAuthenticateCheck(bool value) async {
    setFinishWorking(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      try {
        var check = await Authentication.authenticateWithBiometricsFunc();
        if (check) {
          setState(() {
            prefs.setString("token_biometrics", token);
            prefs.setString("is_enable_login", "yes");
          });

          ToastMessage.showColoredToast(
              "Enable login by biometrics successful", "OK");
        } else {
          setState(() {
            prefs.setString("token_biometrics", "");
            prefs.setString("is_enable_login", "no");
          });
          ToastMessage.showColoredToast(
              "Enable login by biometrics fail", "ERROR");
        }
      } catch (e) {
        setState(() {
          prefs.setString("token_biometrics", "");
          prefs.setString("is_enable_login", "no");
        });
        ToastMessage.showColoredToast(e.toString(), "ERROR");
      }
    } else {
      setState(() {
        prefs.setString("token_biometrics", "");
        prefs.setString("is_enable_login", "no");
      });
      ToastMessage.showColoredToast(
          "Disable login by biometrics successful", "OK");
    }

    setFinishWorking(false);
  }

  _showContent() {
    return SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
            start: 15.0, end: 15.0, top: 45.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[setBuilder()],
        ));
  }

  setBuilder() {
    double radius = 15;
    double opacity = 0.7;
    double spreadRadius = 7;
    double blurRadius = 7;
    double offsetX = 0;
    double offsetY = 3;
    double paddingBox1 = 2;

    return Container(
        padding: const EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15.0),
        //     color: Theme.of(context).colorScheme.controlSettings),
        child: Container(
          child: Column(
            children: [
              Container(
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.fingerprint_sharp,
                        size: 20,
                        color: Theme.of(context).colorScheme.settingIconColor,
                      ),
                      Container(width: 10),
                      Text(LocalizationUtil.translate('Kich_Hoat_Dang_Nhap')!,
                          textScaleFactor: 1.07,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .settingIconColor)),
                      const Spacer(),
                      SizedBox(
                          // height: 45,
                          // width: 55,
                          child: FittedBox(
                        child: Switch.adaptive(
                          onChanged: (check) {
                            isDisabled = check;
                            enableAuthenticateCheck(isDisabled);
                          },
                          value: isDisabled,
                          activeColor: Theme.of(context).colorScheme.colorMainBackground,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey,
                        ),
                        fit: BoxFit.fill,
                      ))
                      // Switch(
                      //     value: isDisabled,
                      //     onChanged: (check) {
                      //       setState(() {
                      //         isDisabled = check;
                      //         enableAuthenticateCheck(isDisabled);
                      //       });
                      //     })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          _showContent(),
          showCircularProgress(_isLoading, Colors.black)
        ],
      ),
    );
  }
}
