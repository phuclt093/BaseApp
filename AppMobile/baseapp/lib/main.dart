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
import 'helpers/color.dart';
import 'helpers/constant.dart';
import 'helpers/http_helper.dart';
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
        statusBarColor: colors.transparentColor));
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Consumer<LanguageNotifier>(builder: (context, data, child) {
      return Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, widget) {
            return ScrollConfiguration(
                behavior: MyBehavior(),
                child: Directionality(
                    textDirection: (data.isRTL == null || data.isRTL == "0")
                        ? ui.TextDirection.ltr
                        : ui.TextDirection.rtl,
                    child: widget!));
          },
          title: appName,
          theme: ThemeData(
            primaryColor: colors.primary,
            splashColor: colors.primary,
            fontFamily: 'Sarabun',
            //'Neue Helvetica',
            canvasColor: colors.bgColor,
            brightness: Brightness.light,
            scaffoldBackgroundColor: colors.colorBackgroundMomo,
            appBarTheme: const AppBarTheme(
                elevation: 0.0,
                backgroundColor: colors.transparentColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: colors.transparentColor)),
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: colors.primaryApp)
                    .copyWith(
                        secondary: colors.primary,
                        brightness: Brightness.light),
          ),
          darkTheme: ThemeData(
            fontFamily: 'Sarabun',
            primaryColor: colors.secondaryColor,
            splashColor: colors.primary,
            brightness: Brightness.dark,
            canvasColor: colors.darkModeColor,
            scaffoldBackgroundColor: colors.darkModeColor,
            appBarTheme: const AppBarTheme(
                elevation: 0.0,
                backgroundColor: colors.transparentColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: colors.transparentColor)),
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: colors.primaryApp)
                    .copyWith(
                        secondary: colors.primary, brightness: Brightness.dark),
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
