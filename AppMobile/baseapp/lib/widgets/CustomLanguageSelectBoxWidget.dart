import 'package:baseapp/commons/themeValue.dart';
import 'package:flutter/material.dart';
import 'package:baseapp/utils/localizationUtil.dart';

class CustomLanguageSelectBoxWidget extends StatelessWidget {
  CustomLanguageSelectBoxWidget(
      {super.key,
      this.fontSize,
      this.selectedLang,
      required this.onChangeFunc,
      this.colorFont,
      this.coloBackground,
      this.dropdownItems,
      this.colorIconEnabled});

  //Variables
  Color? colorFont;
  Color? colorIconEnabled;
  final Function(Object? value) onChangeFunc;
  Color? coloBackground;
  double? fontSize;
  Locale? selectedLang;
  List<DropdownMenuItem<Locale>>? dropdownItems = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(

        child: DropdownButton(
          iconEnabledColor: colorIconEnabled,
      style: TextStyle(
          color: colorFont, fontWeight: FontWeight.bold, fontSize: fontSize),
      value: selectedLang,
      dropdownColor: coloBackground,
      items: dropdownItems,
      onChanged: onChangeFunc,
    ));
  }

  @override
  void dispose() {}
}
