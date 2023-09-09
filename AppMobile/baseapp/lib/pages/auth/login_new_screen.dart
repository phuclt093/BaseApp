import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:baseapp/commons/themeValue.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authentication.dart';
import 'package:baseapp/pages/common/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/commonUtil.dart';
import 'package:baseapp/utils/localizationUtil.dart';
import '../../data/img.dart';
import '../../helpers/session.dart';
import '../../utils/httpUtil.dart';
import '../common/progress_circle_center.dart';

class LoginNewScreenRoute extends StatefulWidget {
  LoginNewScreenRoute();

  @override
  LoginNewScreenRouteState createState() => LoginNewScreenRouteState();
}

class LoginNewScreenRouteState extends State<LoginNewScreenRoute>
    with TickerProviderStateMixin {
  bool finishLoading = false;
  late String _username, _password;
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

  void showInSnackBar(String value) {}

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
    return Stack(
      children: [
        Image.asset(
          "assets/images/main_background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          //backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                  color: Theme.of(context).colorScheme.colorBackground)),
          body: SingleChildScrollView(
              child: Align(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                  child: Image.asset(
                    Img.get('logo_only.png'),
                    //color: Colors.white,
                  ),
                  width: 80.w,
                  height: 12.h,
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0.5.h, 0, 5.h),
                  child: Text(
                    LocalizationUtil.translate("lblChatYourWay"),
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.colorHint_TextBox),
                  ),
                ),
                UsernameBox(),
                PasswordBox(),
                LoginButtonBox(),

                // Form(
                //   key: _formKey,
                //   child: Container(
                //     margin: EdgeInsets.only(left: 15.w, right: 15.w),
                //     width: MediaQuery.of(context).size.width,
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: <Widget>[
                //         // Container(
                //         //   height: 65,
                //         //   width: 65,
                //         //   child: IconButton(
                //         //     icon: const Icon(
                //         //       Icons.fingerprint,
                //         //       size: 45,
                //         //     ),
                //         //     tooltip: 'Login by biometrics',
                //         //     onPressed: () {
                //         //       ToastMessage.showColoredToast(
                //         //           "Đăng nhập bằng sinh trắc học.", "OK");
                //         //       _handleRefreshTokenByBiometrics();
                //         //     },
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
        )
      ],
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
      _username = userName.text;
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
              prefs.setString("username_bi", _username);
              prefs.setString("password_bi", _password);

              if (isCheckedRememberMe) {
                prefs.setString("initUsername", _username);
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

  UsernameBox() {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 1.h, top: 2.h),
      child: TextFormField(
        focusNode: emailFocus,
        textInputAction: TextInputAction.next,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: Theme.of(context).colorScheme.colorFont_TextBox,
            fontWeight: FontWeight.bold),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return LocalizationUtil.translate('username_required')!;
          }
        },
        onChanged: (String value) {
          setState(() {
            _username = value;
          });
        },
        controller: userName,
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus, passFocus);
        },
        decoration: InputDecoration(
          hintText: LocalizationUtil.translate('Username')!,
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .colorHint_TextBox
                  .withOpacity(0.5)),
          filled: true,
          fillColor: Theme.of(context)
              .colorScheme
              .colorBackground_TextBox
              .withOpacity(0.7),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.colorBorderActive_TextBox),
            borderRadius:
                BorderRadius.circular(themeValue.TextBox_BorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.colorBorder_TextBox),
            borderRadius:
                BorderRadius.circular(themeValue.TextBox_BorderRadius),
          ),
        ),
      ),
    );
  }

  PasswordBox() {
    //Login User
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h, top: 1.h),
      child: TextFormField(
        focusNode: passFocus,
        textInputAction: TextInputAction.done,
        controller: passWord,
        obscureText: _isObsecure,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
            color: Theme.of(context).colorScheme.colorFont_TextBox,
            fontWeight: FontWeight.bold),
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
                  .colorHint_TextBox
                  .withOpacity(0.5)),
          suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12.0),
              child: IconButton(
                icon: _isToggle
                    ? Icon(Icons.visibility_rounded, size: 20)
                    : Icon(Icons.visibility_off_rounded, size: 20),
                splashColor: themeValue.colorBackgroundMomo,
                onPressed: () {
                  _toggle();
                },
              )),
          filled: true,
          fillColor: Theme.of(context)
              .colorScheme
              .colorBackground_TextBox
              .withOpacity(0.7),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.colorBorderActive_TextBox),
            borderRadius:
                BorderRadius.circular(themeValue.TextBox_BorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.colorBorder_TextBox),
            borderRadius:
                BorderRadius.circular(themeValue.TextBox_BorderRadius),
          ),
        ),
      ),
    );
  }

  LoginButtonBox() {
    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 1.h, top: 1.h),
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
            height: 6.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.colorButtonLogin_Background,
                borderRadius:
                    BorderRadius.circular(themeValue.Button_BorderRadius)),
            child: Text(
              LocalizationUtil.translate('login_txt')!, //login_btn
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.colorButtonLogin_Text),
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
              submitLoginForm(_username, _password, deviceID, false);

              //signInWithEmailPassword(email!.trim(), pass!);
            } else {
              // showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
            }
          }),
    );
  }
}
