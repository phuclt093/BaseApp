import 'dart:convert';
import 'package:baseapp/data/img.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authenticate_biometrics_screen.dart';
import 'package:baseapp/pages/home/home_screen_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/utils/localizationUtil.dart';
import '../../commons/themeValue.dart';
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
                  top: BorderSide(width: 6, color: Colors.transparent),
                ),
              )
            : const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 4, color: Colors.transparent),
                ),
              ),
        child: Column(
          children: [
            Icon(
              icon,
              //size: 15,
              color: index == _selectedIndex
                  ? Colors.greenAccent
                  : Colors.red,
            ),
            Text(
              nameIcon,
              style: TextStyle(
                color: index == _selectedIndex
                    ? Colors.greenAccent
                    : Colors.red,
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
            ? showCircularProgress(_isLoading, Colors.red)
            : IndexedStack(
                children: fragments,
                index: _selectedIndex,
              ),
      ),
    );
  }
}
