import 'dart:convert';
import 'package:baseapp/data/img.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authenticate_biometrics_screen.dart';
import 'package:baseapp/pages/home/home_screen_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/localizationUtil.dart';
import '../../helpers/color.dart';
import 'package:baseapp/helpers/session.dart';


class HomeScreenRoute extends StatefulWidget {
  HomeScreenRoute({Key? key}) : super(key: key);

  @override
  HomeScreenRouteState createState() => HomeScreenRouteState();
}

class HomeScreenRouteState extends State<HomeScreenRoute>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Token token =
      Token(username: "", idToken: "", userTypeID: "", email: "", fullName: "");

  bool _isLoading = true;
  List<Widget> fragments = [];
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;
  bool finishLoading = false;
  bool _isNetworkAvail = true;
  String codeLangue = "vi";

  List<IconData> iconList = [
    Icons.house,
    Icons.account_circle
  ];
  List<String> listIconName = [];

  @override
  void initState() {
    listIconName = [
      LocalizationUtil.translate("Home")!,
      LocalizationUtil.translate("Account")!
    ];

    fetchThongTinSession();
    super.initState();
    () async {
      fragments = [
        Container(), Container()
      ];
    }();
    setTimeout(() {
      _isLoading = false;
    }, 700);
  }

  void setFinishWorking(bool status) {
    if (mounted) {
      setState(() {
        finishLoading = status;
      });
    }
  }

  // Future getListChuDe() async {
  //   _isNetworkAvail = await isNetworkAvailable();
  //   if (_isNetworkAvail) {
  //     String ulr  = "ThongBaoSinhVien/GetDanhSachChuDe_TheoSinhVien";
  //     var deviceID = await Authentication.getDeviceID();
  //     Map<String, String> parameters = {
  //       "deviceid": deviceID,
  //     };
  //
  //     String resultStr = await HttpHelper.fetchPost(
  //         ulr, parameters, context, setFinishWorking);
  //     var tabnew = TabNews(
  //         LocalizationUtil.translate('Important_Notifications_LBL')!,
  //         "ThongBaoSinhVien/LayThongBaoQuanTrongSinhVien",
  //         "");
  //
  //     var tabnew1 = TabNews(LocalizationUtil.translate('Latest_Notifications_LBL')!,
  //         "ThongBaoSinhVien/LayThongBaoMoiSinhVien", "");
  //     lstTabNews.add(tabnew);
  //     lstTabNews.add(tabnew1);
  //     if (mounted) {
  //       setState(() {
  //         final json = jsonDecode(resultStr);
  //         lstChuDe.clear();
  //         if (json['lstChuDe'] != null) {
  //           json['lstChuDe'].forEach((v) {
  //             lstChuDe.add(ChuDe.fromJson(v));
  //           });
  //
  //           for (var chuDeItem in lstChuDe) {
  //             var tabnew = TabNews(
  //                 LocalizationUtil.translate(context, chuDeItem.ten ?? "")!,
  //                 "ThongBaoSinhVien/LayThongBaoTheoChuDeID",
  //                 chuDeItem.id.toString());
  //
  //             lstTabNews.add(tabnew);
  //           }
  //         }
  //       });
  //     }
  //   } else {
  //     showSnackBar(LocalizationUtil.translate('internetmsg')!, context);
  //     setState(() {
  //       finishLoading = false;
  //     });
  //   }
  // }

  void onDrawerShow() {
    Future.delayed(const Duration(seconds: 1), () {});

    _scaffoldKey.currentState?.openDrawer();
  }

  void onLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("id_token");
    prefs.remove("userTypeID");
    prefs.remove("email");
    prefs.remove("fullName");
    prefs.remove("userType");
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  Future fetchThongTinSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = prefs.getString("id_token") ?? "";
    String username = prefs.getString("username") ?? "";
    String userTypeID = prefs.getString("userTypeID") ?? "";
    String email = prefs.getString("email") ?? "";
    String fullName = prefs.getString("fullName") ?? "";
    String userType = prefs.getString("userType") ?? "";

    setState(() {
      token = Token(
          email: email,
          fullName: fullName,
          idToken: idToken,
          username: username,
          userTypeID: userTypeID);

      //onLoadMenu(username);
    });
  }

  void onOpenAuthenticateBiometrics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AuthenticateBiometricsRoute(token: token.idToken ?? ""),
      ),
    ).then((value) => {});
  }

  //when home page in back click press
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (_selectedIndex != 0) {
      _selectedIndex = 0;

      return Future.value(false);
    } else if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // showSnackBar(LocalizationUtil.translate('EXIT_WR')!, context);

      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget buildNavBarItem(IconData icon, int index, String nameIcon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / iconList.length,
        decoration: index == _selectedIndex
            ? const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 6, color: colors.transparentColor),
                ),
              )
            : const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 4, color: colors.transparentColor),
                ),
              ),
        child: Column(
          children: [
            Icon(
              icon,
              //size: 15,
              color: index == _selectedIndex
                  ? colors.primary
                  : colors.disabledColor,
            ),
            Text(
              nameIcon,
              style: TextStyle(
                color: index == _selectedIndex
                    ? colors.primary
                    : colors.disabledColor,
                fontSize: index == _selectedIndex ? 12 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomBar() {
    List<Widget> _navBarItemList = [];
    for (var i = 0; i < iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(iconList[i], i, listIconName[i]));
    }
    return Padding(
        padding: EdgeInsetsDirectional.zero,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.boxColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0)),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                child: Row(
                  children: _navBarItemList,
                ))));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: colors.bgColor,
        // appBar: setAppBar(),
        appBar: null,
        extendBody: true,
        bottomNavigationBar: bottomBar(),
        body: _isLoading
            ? showCircularProgress(_isLoading, colors.primary)
            : IndexedStack(
                children: fragments,
                index: _selectedIndex,
              ),
      ),
    );
  }
  //
  // setAppBar() {
  //   var textsizeSearch = 16.0;
  //   Function onTapFnc = () {
  //     Navigator.push(context,
  //         CupertinoPageRoute(builder: (context) => HomeScreenSearchRoute()));
  //   };
  //   return PreferredSize(
  //       preferredSize: Size(double.infinity, 70), //72
  //       child: Container(
  //           color: Theme.of(context).colorScheme.colorBackground_AppBar,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
  //                 Expanded(
  //                   flex: 6,
  //                   child: Container(
  //                       margin: EdgeInsets.only(left: 15, right: 15, bottom: 0),
  //                       child: CommonWidget.getSearchBar(
  //                           colorPrefixIcon: Theme.of(context)
  //                               .colorScheme
  //                               .color_SearchBoxLabel,
  //                           autoFocus: false,
  //                           hintText: getTranslated(
  //                               context, "NhapTimKiemChucNang_lbl"),
  //                           context: context,
  //                           hintStyle: TextStyle(
  //                               fontSize: textsizeSearch,
  //                               color: Theme.of(context)
  //                                   .colorScheme
  //                                   .color_SearchBoxHint,
  //                               fontWeight: FontWeight.bold),
  //                           fillColor: Theme.of(context)
  //                               .colorScheme
  //                               .colorBackground_SearchBox
  //                               .withOpacity(0.3),
  //                           onTap: onTapFnc,
  //                           height: 32.0,
  //                           readOnly: true)),
  //                 ),
  //                 Expanded(
  //                   flex: 3,
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                           flex: 1,
  //                           child: ElevatedButton(
  //                             onPressed: () {
  //                               Navigator.of(context).push(MaterialPageRoute(
  //                                   builder: (BuildContext context) =>
  //                                       QRViewExample()));
  //                             },
  //                             child: Icon(Icons.qr_code_scanner,
  //                                 color: Theme.of(context)
  //                                     .colorScheme
  //                                     .color_SearchBoxLabel),
  //                             style: ElevatedButton.styleFrom(
  //                               elevation: 0.0,
  //                               shadowColor: Colors.transparent,
  //                               shape: CircleBorder(),
  //                               padding: EdgeInsets.all(0),
  //                               backgroundColor: Theme.of(context)
  //                                   .colorScheme
  //                                   .colorBackground_SearchBox
  //                                   .withOpacity(0.3), // <-- Button color
  //                             ),
  //                           )),
  //                       Expanded(
  //                         flex: 1,
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             _selectedIndex = 3;
  //                             setState(() {});
  //                           },
  //                           child: CommonWidget.getCircleAvatar(
  //                               radius: 15,
  //                               imageProvider:
  //                                   AssetImage(Img.get("unknown_avatar.jpg"))),
  //                           style: ElevatedButton.styleFrom(
  //                             elevation: 0.0,
  //                             shadowColor: Colors.transparent,
  //                             shape: CircleBorder(),
  //                             padding: EdgeInsets.all(0),
  //                             backgroundColor: Theme.of(context)
  //                                 .colorScheme
  //                                 .colorBackground_SearchBox
  //                                 .withOpacity(0.3), // <-- Button color
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ]),
  //             ],
  //           )));
  // }
}
