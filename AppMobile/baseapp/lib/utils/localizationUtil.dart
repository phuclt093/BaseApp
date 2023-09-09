import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:flutter/material.dart';

class LocalizationUtil {
  static String translate(String key) {
    var temp = tr(key);
    if (temp == null) {
      temp = "";
    }
    return temp;
  }

  static String GetLanguage() {
    return "";
  }

  static void ChangeLanguage(Locale code, BuildContext context) {
    EasyLocalization.of(context)!.setLocale(code);
    EasyLocalization.of(context)!
        .delegate
        .localizationController!
        .loadTranslations()
        .then((value) {
      Localization.load(code,
          translations: EasyLocalization.of(context)!
              .delegate
              .localizationController!
              .translations);
    });
  }
}
