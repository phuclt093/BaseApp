import 'package:flutter/material.dart';

class ConstValue {
  // static String BaseUrlTest = "https://pj-tntt.conveyor.cloud/Vfis/";
  //
  // static const double EdgeInsetsInt = 20;
  // static NumberFormat FormatterThousands = NumberFormat('#,###,000');

  // static bool? isSearching = false;
  // static String? qrcode = "";
  // static String? thietbi = "";
  // static String? thoigian = "";
  // static String? diadiem = "";

  // static String? APP_THEME = "";

  static String path_full_logo = "logo_full.png";
  static String path_only_logo = "logo_only.png";

  static String chucnangSearchText = "";
  static String defaultLanguageCode = "en";
  static String recentMenuIDStr = "";
  static String BaseUrl = "https://restapi.tdtu.edu.vn/TDT/";
  static String BaseUrlSTDPortal = "http://test12.tdtu.edu.vn/";


  static List<DropdownMenuItem<Locale>> dropdownItems = [
    const DropdownMenuItem(child: Text("VI"), value: Locale("vi","VN")),
    const DropdownMenuItem(child: Text("US"), value: Locale("en","US")),
  ];

}
