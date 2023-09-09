import 'package:flutter/material.dart';

import 'language_model.dart';

class LanguageNotifier with ChangeNotifier {
  String? languageCode;
  String? isRTL;
  List<LanguageModel> languageList = [];

  getLanguageCode() => languageCode;

  changeSetting(String language, String RTL) {
    languageCode = language;
    isRTL = RTL;
    notifyListeners();
  }

  /* void setLanguageCode(String language) {
    languageCode = language;
    notifyListeners();
  }*/

  void setLanguageList(List<LanguageModel> list) {
    languageList.clear();
    languageList = list;
    notifyListeners();
  }

/* void setRTL(String RTL) {
    languageCode = language;
    notifyListeners();
  }*/
}
