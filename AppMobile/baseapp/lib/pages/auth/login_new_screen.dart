import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:baseapp/helpers/color.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authentication.dart';
import 'package:baseapp/pages/common/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/commonUtil.dart';
import 'package:baseapp/utils/localizationUtil.dart';
import '../../data/img.dart';
import '../../data/my_colors.dart';
import '../../helpers/session.dart';
import '../../helpers/http_helper.dart';
import '../common/progress_circle_center.dart';

class LoginNewScreenRoute extends StatefulWidget {
  LoginNewScreenRoute();

  @override
  LoginNewScreenRouteState createState() => LoginNewScreenRouteState();
}

class LoginNewScreenRouteState extends State<LoginNewScreenRoute>
    with TickerProviderStateMixin {
  bool finishLoading = false;
  late String _email, _password;
  bool isCheckedRememberMe = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObsecure = true;
  bool _isToggle = true;

  String initUsername = "";
  String initPassword = "";
  String? userType = "Student";
  bool isChecked = false;
  bool _isNetworkAvail = true;
  String? privacyTitle, privacyDesc, termsTitle, termsDesc;
  bool isTermsShow = false;
  String codeLangue = "vi";

  final TextEditingController userName = TextEditingController();
  final TextEditingController passWord = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double radius = 15;
  double opacity = 0.7;
  double spreadRadius = 7;
  double blurRadius = 7;
  double offsetX = 0;
  double offsetY = 3;

  void showInSnackBar(String value) {
  }

  @override
  void initState() {
    getPreviousUsernamePassword();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        finishLoading = true;
      });
    });
    super.initState();
    setTimeout(() {
      getCodeLangge();
    }, 700);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(color: Theme.of(context).colorScheme.colorBackground)),
      body: SingleChildScrollView(
          child: Align(
            child: Column(
              children: <Widget>[
                Container(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                  child: Image.asset(
                    Img.get('logo-white.png'),
                    //color: Colors.white,
                  ),
                  width: 40.w,
                  height: 17.h,
                ),
                Container(height: 10),
                !finishLoading
                    ? AnimatedOpacity(
                  opacity: finishLoading ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: ProgressCircleCenter(context).buildLoading(),
                )
                    : Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(
                        top: 35.0, bottom: 20.0, start: 20.0, end: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        usernameSet(),
                        passSet(),
                        Container(height: 25),
                        Container(
                          height: 65,
                          width: 65,
                          child: IconButton(
                            icon: const Icon(
                              Icons.fingerprint,
                              size: 45,
                            ),
                            tooltip: 'Login by biometrics',
                            onPressed: () {
                              ToastMessage.showColoredToast(
                                  "Đăng nhập bằng sinh trắc học.", "OK");
                              _handleRefreshTokenByBiometrics();
                            },
                          ),
                        ),
                        Container(height: 20),
                        loginBtn(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
  getCodeLangge() async {
    setState(() async {
      codeLangue = await LocalizationUtil.GetLanguage();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getPreviousUsernamePassword() async {
    setFinishWorking(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName.text = prefs.getString("initUsername") ?? "";
      _email = userName.text;
      _password = passWord.text;

      setFinishWorking(true);
    });
  }

  void setFinishWorking(bool status) {
    if (mounted) {
      setState(() {
        finishLoading = status;
      });
    }
  }

  void _handleRefreshTokenByBiometrics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String tokenBiometrics = prefs.getString("token_biometrics") ?? "";
    String isEnableLogin = prefs.getString("is_enable_login") ?? "no";
    if (isEnableLogin == "yes") {
      var check = await Authentication.authenticateWithBiometricsFunc();
      if (check) {
        String userNameBi = prefs.getString("username_bi") ?? "";
        String passwordBi = prefs.getString("password_bi") ?? "";
        var deviceID = await Authentication.getDeviceID();
        submitLoginForm(userNameBi, passwordBi, deviceID, true);
      } else {
        ToastMessage.showColoredToast(
            LocalizationUtil.translate("LOGIN_FAIL_LBL")!, "ERROR");
        setFinishWorking(true);
      }
    } else {
      ToastMessage.showColoredToast(
          LocalizationUtil.translate('You_have_not_enabled_biometric_login')!,
          "WARNING");
      setFinishWorking(true);
    }
  }

  Future submitLoginForm(String usernameval, String passwordval,
      String deviceid, bool isLoginByBiometrics) async {
    _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
    if (_isNetworkAvail) {
      String ulr = "login/checklogin";
      setFinishWorking(false);
      Map<String, String> parameters = {
        'username': usernameval,
        'password': passwordval,
        'deviceid': deviceid
      };

      String resultStr = await HttpHelper.fetchPostWithoutToken(
          ulr, parameters, context, setFinishWorking);

      try {
        final json = jsonDecode(resultStr);
        var token = Token.fromJson(json);
        if (token.idToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          setState(() {
            prefs.setString("id_token", token.idToken ?? "");
            prefs.setString("username", token.username ?? "");
            prefs.setString("userTypeID", token.userTypeID ?? "");
            prefs.setString("email", token.email ?? "");
            prefs.setString("fullName", token.fullName ?? "");
            prefs.setString("userType", token.userType ?? "");
            prefs.setString("passwordTest", _password ?? "");
            prefs.setString("hashinfo", token.hashinfo ?? "");

            if (!isLoginByBiometrics) {
              prefs.setString("username_bi", _email);
              prefs.setString("password_bi", _password);

              if (isCheckedRememberMe) {
                prefs.setString("initUsername", _email);
                prefs.setString("initPassword", _password);
                prefs.setString("initUserType", userType ?? "");
              } else {
                prefs.setString("initUsername", "");
                prefs.setString("initPassword", "");
                prefs.setString("initUserType", "");
              }
            }
          });

          Navigator.pushNamedAndRemoveUntil(
              context, '/home', ModalRoute.withName('/home'));
          ToastMessage.showColoredToast(
              LocalizationUtil.translate('login_msg')!, "OK");
        } else {
          ToastMessage.showColoredToast(json["message"], "ERROR");
          setFinishWorking(true);
        }
      } catch (e) {
        ToastMessage.showColoredToast(
            LocalizationUtil.translate("LOGIN_FAIL_LBL")!, "ERROR");
        setFinishWorking(true);
      } finally {
        setFinishWorking(true);
      }
    } else {
      // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _toggle() {
    setState(() {
      _isToggle = !_isToggle;
      //secure entered text
      _isObsecure = !_isObsecure;
    });
  }

  usernameSet() {
    //Login User
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        child: TextFormField(
          focusNode: emailFocus,
          textInputAction: TextInputAction.next,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Theme.of(context).colorScheme.fontColor),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocalizationUtil.translate('username_required')!;
            }
          },
          onChanged: (String value) {
            setState(() {
              _email = value;
            });
          },
          controller: userName,
          onFieldSubmitted: (v) {
            _fieldFocusChange(context, emailFocus, passFocus);
          },
          decoration: InputDecoration(
            hintText: LocalizationUtil.translate('StudentID')!,
            hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color:
                    Theme.of(context).colorScheme.darkColor.withOpacity(0.5)),
            filled: true,
            fillColor: Theme.of(context).colorScheme.boxColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .borderColor
                      .withOpacity(0.7)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  passSet() {
    //Login User
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          child: TextFormField(
            focusNode: passFocus,
            textInputAction: TextInputAction.done,
            controller: passWord,
            obscureText: _isObsecure,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).colorScheme.fontColor,
                ),
            // validator: (val) => passValidation(val!, context),
            onChanged: (String value) {
              setState(() {
                _password = value;
              });
            },
            decoration: InputDecoration(
              hintText: LocalizationUtil.translate('pass_lbl')!,
              hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .darkColor
                        .withOpacity(0.5),
                  ),
              suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12.0),
                  child: IconButton(
                    icon: _isToggle
                        ? Icon(Icons.visibility_rounded, size: 20)
                        : Icon(Icons.visibility_off_rounded, size: 20),
                    splashColor: colors.clearColor,
                    onPressed: () {
                      _toggle();
                    },
                  )),
              filled: true,
              fillColor: Theme.of(context).colorScheme.boxColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 17),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .borderColor
                        .withOpacity(0.6)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ));
  }

  loginBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
            height: 6.5.h,
            width: 80.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(7.0)),
            child: Text(
              LocalizationUtil.translate('login_txt')!, //login_btn
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: colors.tempboxColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  letterSpacing: 0.6),
            ),
          ),
          onTap: () async {
            FocusScope.of(context).unfocus(); //dismiss keyboard
            _isNetworkAvail = await CommonUtil.IsNetworkAvailable();
            if (_isNetworkAvail) {
              setState(() {
                finishLoading = true;
              });

              var deviceID = await Authentication.getDeviceID();
              submitLoginForm(_email, _password, deviceID, false);

              //signInWithEmailPassword(email!.trim(), pass!);
            } else {
              // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
            }
          }),
    );
  }
}
