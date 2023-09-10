import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:baseapp/models/language_notifier.dart';
import 'package:baseapp/models/string.dart';
import 'package:baseapp/pages/main/landing.dart';
import 'package:baseapp/pages/auth/login_new_screen.dart';
import 'package:baseapp/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'commons/themeValue.dart';
import 'helpers/constant.dart';
import 'utils/httpUtil.dart';
import 'package:provider/provider.dart';
import 'helpers/theme.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Timer.periodic(const Duration(seconds: 900), (timer) {
  //   HttpHelper.refeshValidateToken();
  // });

  final prefs = await SharedPreferences.getInstance();
  String theme = "";
  if(prefs.containsKey(APP_THEME) == false){
    theme = LIGHT;
  }
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/language',
        useOnlyLangCode: false,
        fallbackLocale: const Locale('en', 'US'),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
                create: (BuildContext context) {
              if (theme == DARK) {
                isDark = true;
                prefs.setString(APP_THEME, DARK);
              } else if (theme == LIGHT) {
                isDark = false;
                prefs.setString(APP_THEME, LIGHT);
              }
              return ThemeNotifier(
                  theme == LIGHT ? ThemeMode.light : ThemeMode.dark);
            }),
            ChangeNotifierProvider<LanguageNotifier>(
                create: (context) => LanguageNotifier()),
          ],
          child: MyApp(),
        )),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // streamLangController!.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //uiOverlayStyle
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: (isDark != null && isDark == true)
            ? Brightness.dark
            : Brightness.light,
        statusBarIconBrightness: (isDark != null && isDark == true)
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: Colors.transparent));
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // builder: (context, widget) {
        //   return ScrollConfiguration(
        //       behavior: MyBehavior(),
        //       child: Directionality(
        //           textDirection: (data.isRTL == null || data.isRTL == "0")
        //               ? ui.TextDirection.ltr
        //               : ui.TextDirection.rtl,
        //           child: widget!));
        // },
        title: appName,
        theme: ThemeData(
          primaryColor: Colors.blue,
          splashColor: themeValue.splashColorLight,
          fontFamily: 'Sarabun',
          //'Neue Helvetica',
          canvasColor: Colors.blue,
          brightness: themeValue.brightnessLight,
          scaffoldBackgroundColor: themeValue.splashBackgroundColorLight,
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: themeValue.statusBarBrightnessLight,
                  statusBarIconBrightness: themeValue.statusBarIconBrightnessLight,
                  statusBarColor: themeValue.statusBarColorLight)),
          // colorScheme:
          //     ColorScheme.fromSwatch(primarySwatch: Colors.red)
          //         .copyWith(
          //             secondary: Colors.red,
          //             brightness: Brightness.light),
        ),
        darkTheme: ThemeData(
          fontFamily: 'Sarabun',
          primaryColor: Colors.red,
          splashColor:  themeValue.splashColorDark,
          brightness: themeValue.brightnessDark,
          canvasColor:  Colors.red,
          scaffoldBackgroundColor:  themeValue.splashBackgroundColorDark,
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor:  Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: themeValue.statusBarBrightnessDark,
                  statusBarIconBrightness: themeValue.statusBarIconBrightnessDark,
                  statusBarColor: themeValue.statusBarColorDark)),
          // colorScheme:
          //     ColorScheme.fromSwatch(primarySwatch: Colors.red)
          //         .copyWith(
          //             secondary: Colors.red, brightness: Brightness.dark),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Landing(),
          '/home': (context) => HomeScreenRoute(),
          '/login': (context) => LoginNewScreenRoute(),
        },
        themeMode: themeNotifier.getThemeMode(),
      );
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
