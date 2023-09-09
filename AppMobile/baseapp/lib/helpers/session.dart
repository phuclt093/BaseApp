import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:baseapp/commons/themeValue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:baseapp/models/menu_model.dart';
import '../data/img.dart';

// showSnackBar(String msg, BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         msg,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Theme.of(context).colorScheme.fontColor),
//       ),
//       duration: const Duration(milliseconds: 1000), //bydefault 4000 ms
//       backgroundColor: isDark! ? colors.tempdarkColor : colors.bgColor,
//       elevation: 1.0,
//     ),
//   );
// }

//prefrence string set using this function
setPrefrence(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

//prefrence string get using this function
Future<String?> getPrefrence(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

//prefrence boolean set using this function
setPrefrenceBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

//prefrence boolean get using this function
Future<bool> getPrefrenceBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

setPrefrenceList(String key, String query) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? valueList = await getPrefrenceList(key);
  if (!valueList!.contains(query)) {
    if (valueList.length > 4) valueList.removeAt(0);
    valueList.add(query);

    prefs.setStringList(key, valueList);
  }
}

Future<List<String>?> getPrefrenceList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key);
}

Widget showCircularProgress(bool _isProgress, Color color) {
  if (_isProgress) {
    // return Center(
    //     child: CircularProgressIndicator(
    //   valueColor: AlwaysStoppedAnimation<Color>(color),
    // ));
    return Center(
      child: Container(
        width: 200,
        //height: 30,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // CircleAvatar(
            //   backgroundImage:
            //       ExactAssetImage(Img.get('logo_only.png'), scale: 0.05),
            //   // Optional as per your use case
            //   // minRadius: 30,
            //   // maxRadius: 70,
            //   radius: 15,
            //   backgroundColor: Colors.white,
            // ),
            Image.asset(Img.get('logo_only.png'),
                fit: BoxFit.fill, height: 20, width: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 238, 44, 53)),
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
    );
  }
  return const SizedBox.shrink();
  /* Container(
    height: 0.0,
    width: 0.0,
  ); */
}

placeHolder() {
  return Image.asset("assets/images/placeholder.png");
}

//network image in error
errorWidget(double height, double width) {
  return Image.asset(
    "assets/images/placeholder.png",
    height: height,
    width: width,
  );
}

//password validation check
// String? passValidation(String value, BuildContext context) {
//   if (value.length == 0)
//     return LocalizationUtil.translate('pwd_required')!;
//   else if (value.length <= 5)
//     return LocalizationUtil.translate('pwd_length')!;
//   else
//     return null;
// }

// String? convertToAgo(BuildContext context, DateTime input, int from) {
//   Duration diff = DateTime.now().difference(input);
//
//   if (diff.inDays >= 1) {
//     if (from == 0) {
//       var newFormat = DateFormat("dd MMMM yyyy");
//       final newsDate1 = newFormat.format(input);
//       return newsDate1;
//     } else if (from == 1) {
//       return "${diff.inDays} ${LocalizationUtil.translate('days')} ${LocalizationUtil.translate('ago')}";
//     } else if (from == 2) {
//       var newFormat = DateFormat("dd MMMM yyyy HH:mm:ss");
//       final newsDate1 = newFormat.format(input);
//       return newsDate1;
//     }
//   } else if (diff.inHours >= 1) {
//     if (input.minute == 00) {
//       return "${diff.inHours} ${LocalizationUtil.translate('hours')} ${LocalizationUtil.translate('ago')}";
//     } else {
//       if (from == 2) {
//         return "${LocalizationUtil.translate('about')} ${diff.inHours} ${LocalizationUtil.translate('hours')} ${input.minute} ${LocalizationUtil.translate('minutes')} ${LocalizationUtil.translate('ago')}";
//       } else {
//         return "${diff.inHours} ${LocalizationUtil.translate('hours')} ${input.minute} ${LocalizationUtil.translate('minutes')} ${LocalizationUtil.translate('ago')}";
//       }
//     }
//   } else if (diff.inMinutes >= 1) {
//     return "${diff.inMinutes} ${LocalizationUtil.translate('minutes')} ${LocalizationUtil.translate('ago')}";
//   } else if (diff.inSeconds >= 1) {
//     return "${diff.inSeconds} ${LocalizationUtil.translate('seconds')} ${LocalizationUtil.translate('ago')}";
//   } else {
//     return "${LocalizationUtil.translate('just_now')}";
//   }
//   return null;
// }

Icon setCoverageIcon(BuildContext context) {
  return Icon(Icons.image,
      color: Theme.of(context).colorScheme.fontColor.withOpacity(0.9));
}

// Text setCoverageText(BuildContext context) {
//   return Text(
//     LocalizationUtil.translate('view_full_coverage')!,
//     textAlign: TextAlign.center,
//     style: Theme.of(context).textTheme.subtitle1?.copyWith(
//         color: Theme.of(context).colorScheme.fontColor.withOpacity(0.9),
//         fontWeight: FontWeight.w600),
//   );
// }

contentShimmer(BuildContext context) {
  //bookmarks
  return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.6),
      highlightColor: Colors.grey,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          top: 15.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          //  BouncingScrollPhysics(),
          itemBuilder: (_, i) => Padding(
              padding: EdgeInsetsDirectional.only(
                top: i == 0 ? 0 : 15.0,
              ), //start: 10, end: 10
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.6)),
                  height: 215.0,
                ),
              ])),
          itemCount: 6,
        ),
      ));
}

Widget tableCell(BuildContext context, String text,
    {TextAlign? textAlign = TextAlign.start, Color? color = null}) {
  // var textAlign = TextAlign.start;
  // if (alignment = "1"){

  // }

  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
      text,
      style: Theme.of(context).textTheme.subtitle2?.copyWith(
          color: color ?? Theme.of(context).colorScheme.settingIconColor),
      textAlign: textAlign ?? TextAlign.start,
    ),
  );
}

Widget getIcon(BuildContext context, String imagePath, String nameIcon) {
  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Image.asset(Img.get(imagePath), fit: BoxFit.cover),
        ),
        TextSpan(
            text: nameIcon,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.settingIconColor)),
      ],
    ),
  );
}

Widget getIconFromByte(BuildContext context,String icon) {
  // List<int> codeUnits = icon.codeUnits;
  Uint8List bytes = base64.decode(icon);
  return   Image(image: Image.memory(bytes).image, fit: BoxFit.fill);
}

Widget _icon(BuildContext context, String imagePath, String nameIcon,
    Function function) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkResponse(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
              color: const Color(0xffffffff),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                Img.get(imagePath),
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
          ),
          Container(
            height: 2,
          ),
          Container(
            child: Text(nameIcon,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.settingIconColor)),
            height: 20,
          ),
        ],
      ),
      onTap: () => {function()},
    ),
  );
}

Widget iconFake() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        //border: Border.all(color: Colors.red),
        //color: Color.fromARGB(255, 167, 27, 27),
      ),
      height: 62,
    ),
  );
}

Widget getListMenu(BuildContext context, List<MenuModel> lstMenu, int pageIndex,
    int pageLenght, int numberRow) {
  List<TableRow> lstTableRow = [];

  var lstMenuInPage =
      lstMenu.skip(pageIndex * pageLenght).take(pageLenght).toList();

  for (var k = 0; k < numberRow; k++) {
    List<Widget> lstWidget = [];
    for (var i = 0; i < pageLenght; i++) {
      if (lstMenuInPage.length > i) {
        var item = lstMenuInPage[i];
        if (i ~/ 4 == k) {
          var iconitem =
              _icon(context, item.imageName, item.nameMenu, item.function);
          lstWidget.add(iconitem);
        }
      } else {
        if (i ~/ 4 == k) {
          var iconitem = iconFake();
          lstWidget.add(iconitem);
        }
      }
    }
    lstTableRow.add(TableRow(children: lstWidget));
  }

  final attachmentWidget = Center(
      // width: deviceWidth,
      // height: 100,
      //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Table(
          border: const TableBorder(),
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: lstTableRow));

  return attachmentWidget;
}

void setTimeout(callback, time) {
  Duration timeDelay = Duration(milliseconds: time);
  Timer(timeDelay, callback);
}

String fnGetValidUrl(String url) {
  RegExp urlRegExp =
      new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  var urlMatches = urlRegExp.allMatches(url);
  List<String> urls = urlMatches
      .map((urlMatch) => url.substring(urlMatch.start, urlMatch.end))
      .toList();
  return urls.first;
}

String fnGetValidHtml(String html) {
  var validHtml = html;
  validHtml = validHtml.replaceAll("label", "span");
  return validHtml;
}
