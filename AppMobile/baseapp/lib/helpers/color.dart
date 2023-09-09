import 'package:flutter/material.dart';

extension colors on ColorScheme {
  static MaterialColor primaryApp = const MaterialColor(
    0xffff3f4c,
    const <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color colorWhiteMomo = Color(0xffFEFEFE);
  static const Color colorPinkMomo = Color(0xffD43D8C);
  static const Color colorBackgroundMomo = Color(0xffECECEE); //C9C9C9 F0F0F0

  static const Color primary = Color(0xffff3f4c);
  static const Color tempboxColor = Color(0xffffffff);
  static const Color bgColor = Color(0xffEEEEEE);
  static const Color templightColor = Color(0xffE5E5E5);
  static const Color tempBorderColor = Color(0xff6B6B6B);
  static const Color lightBorderColor = Color(0xff92c4e);
  static const Color lightTextColor = Color(0xfffafafa);
  static const Color textFormFieldColor = Color(0xfff5f4f9);
  static const Color tempdarkColor = Color(0xff305599);
  static const Color darkBorderColor = Color(0xff629afe);
  static const Color darkColor1 = Color(0xff1a2e51);
  static const Color darkModeColor = Color(0xff102041);
  static const Color clearColor = Colors.transparent;
  static const Color blackColor = Colors.black;
  static const Color secondaryColor = Color(0xff102041);
  static const Color disabledColor = Color(0xffbebdc4);
  static const Color settingsIconClrL = Color(0xff5c5c5c);
  // static const Color settingsIconClrD = Color(0xff8db2f5);
  static const Color shadowColor = Color(0xff29000000);
  static const Color lightLikeContainerColor = Color(0xfff5f5f5);
  static const Color dartLikeContainerColor = Color(0xff1b325b);
  static const Color coverageUnSelColor = Color(0xff7b8cac);
  static const Color  colorGrey = Color(0xffE7E7E7);
  static const Color  colorGrey1 = Color(0xff838383);
  static const Color transparentColor = Colors.transparent;
  static const Color colorBlueTDT  = Color(0xff0064A7);

  static List<Color> lstWeekColor = [
    Color(0xffFEC76F),
    Color(0xffB3BE62),
    Color(0xffBE95BE),
    Color(0xff6DBFB8),
    Color(0xffF5945C),
    Color.fromARGB(255, 96, 146, 221),
    Color(0xffFF6C55),
  ];

  Color get colorBackground => this.brightness == Brightness.light ? Colors.white :  Colors.black;

  Color get colorTextChuY => Color(0xffe74c3c);
  Color get colorTextChuYAfter => Color(0xff0000ff);

  Color get borderColor =>
      this.brightness == Brightness.dark ? bgColor : tempBorderColor;

  Color get likeContainerColor => this.brightness == Brightness.dark
      ? dartLikeContainerColor
      : lightLikeContainerColor;

  Color get lightColor =>
      this.brightness == Brightness.dark ? secondaryColor : templightColor;

  Color get boxColor => this.brightness == Brightness.dark
      ? dartLikeContainerColor
      : tempboxColor;

  Color get fontColor =>
      this.brightness == Brightness.dark ? bgColor : darkColor1;

  Color get darkColor =>
      this.brightness == Brightness.dark ? tempboxColor : tempdarkColor;

  Color get skipColor =>
      this.brightness == Brightness.dark ? bgColor : secondaryColor;

  Color get tabColor =>
      this.brightness == Brightness.dark ? primary : secondaryColor;

  /* Color get langSel =>
      this.brightness == Brightness.dark ? tempdarkColor : secondaryColor; */

  Color get agoLabel =>
      this.brightness == Brightness.dark ? darkBorderColor : tempBorderColor;

  Color get coverage =>
      this.brightness == Brightness.dark ? darkBorderColor : bgColor;

  Color get settingIconColor => this.brightness == Brightness.dark
      ? bgColor
      : settingsIconClrL; //settingsIconClrD

  Color get controlBGColor =>
      this.brightness == Brightness.dark ? darkColor1 : textFormFieldColor;

  Color get controlSettings =>
      this.brightness == Brightness.dark ? darkColor1 : tempboxColor;

  Color get colorBackgroundBox =>
      this.brightness == Brightness.dark ? darkColor1 : colorWhiteMomo;

  Color get colorBorder =>
      this.brightness == Brightness.dark ? darkModeColor : colorGrey;


  Color get colorBackground_AppBar =>
      this.brightness == Brightness.dark ?  colorBlueTDT: colorBlueTDT;

  Color get colorBackground_SearchBox =>
      this.brightness == Brightness.dark ?  colorWhiteMomo: blackColor;

  Color get colorBorder_SearchBox =>
      this.brightness == Brightness.dark ? darkModeColor : colorWhiteMomo;

  Color get color_SearchBoxHint =>
      this.brightness == Brightness.dark ? Colors.white60 : colorGrey1;

  Color get color_SearchBoxLabel =>
      this.brightness == Brightness.dark ? colorWhiteMomo : colorWhiteMomo;

  Color get colorBorder_SearchBox_Cancel =>
      this.brightness == Brightness.dark ? colorWhiteMomo : colorWhiteMomo;

  Color get colorBackgroundIcon_Appbar =>
      this.brightness == Brightness.dark ? colorWhiteMomo : blackColor;
}
