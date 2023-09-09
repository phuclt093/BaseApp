import 'package:baseapp/commons/const_value.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baseapp/models/menu_model.dart';
import 'package:baseapp/models/token.dart';
import 'package:baseapp/pages/auth/authenticate_biometrics_screen.dart';
import 'package:baseapp/utils/localizationUtil.dart';
import '../../helpers/color.dart';
import '../../helpers/session.dart';

DateTime loginClickTime = DateTime.now();

class HomeScreenSearchRoute extends StatefulWidget {
  HomeScreenSearchRoute({Key? key}) : super(key: key);

  @override
  HomeScreenSearchRouteState createState() => HomeScreenSearchRouteState();
}

class HomeScreenSearchRouteState extends State<HomeScreenSearchRoute>
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

  List<MenuModel> lstSearched = [];

  List<IconData> iconList = [
    Icons.house,
    Icons.account_circle
  ];
  List<String> listIconName = [

  ];

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
        Container(),
        Container(),
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var resultPage = Column(
      children: [
        Expanded(
            child: IndexedStack(
          children: fragments,
          index: _selectedIndex,
        ))
      ],
    );

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: colors.bgColor,
        // appBar: setAppBar(),
        appBar: null,
        extendBody: true,
        body: _isLoading
            ? showCircularProgress(_isLoading, colors.primary)
            : resultPage,
      ),
    );
  }

  bool? isIconVisible = false;
  TextEditingController? edittextController = new TextEditingController();

  // setAppBar() {
  //   var textsizeSearch = 16.0;
  //   var textsizeCancel = 16.0;
  //   var marginBox1 = EdgeInsets.only(left: 15, right: 15, bottom: 10);
  //   var marginBox2 = EdgeInsets.only(top: 5);
  //
  //   onTapFunc() {}
  //   onChangedFunc(textChanged) {
  //     ConstValue.chucnangSearchText = textChanged;
  //     isIconVisible = false;
  //     if (textChanged.isNotEmpty) {
  //       isIconVisible = true;
  //     }
  //     setState(() {});
  //     // HomeWidget.currentState.setState(() {});
  //   }
  //
  //   onPressSuffix() {
  //     isIconVisible = false;
  //     setState(() {
  //       ConstValue.chucnangSearchText = "";
  //       edittextController!.clear();
  //     });
  //
  //     // HomeWidget.currentState.setState(() {});
  //   }
  //
  //   return PreferredSize(
  //       preferredSize: Size(double.infinity, 70), //72
  //       child: Container(
  //           color: Theme.of(context).colorScheme.colorBackground_AppBar,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
  //                 Expanded(
  //                   flex: 6,
  //                   child: Container(
  //                       margin: marginBox1,
  //                       alignment: Alignment.bottomCenter,
  //                       child: CommonWidget.getSearchBar(
  //                           colorPrefixIcon: Theme.of(context)
  //                               .colorScheme
  //                               .color_SearchBoxLabel,
  //                           hintText: getTranslated(
  //                               context, "NhapTimKiemChucNang_lbl"),
  //                           context: context,
  //                           labelStyle: TextStyle(
  //                               fontSize: textsizeSearch,
  //                               color: Theme.of(context)
  //                                   .colorScheme
  //                                   .color_SearchBoxLabel,
  //                               fontWeight: FontWeight.bold),
  //                           hintStyle: TextStyle(
  //                               fontSize: textsizeSearch,
  //                               color: Theme.of(context)
  //                                   .colorScheme
  //                                   .color_SearchBoxHint,
  //                               fontWeight: FontWeight.bold),
  //                           fillColor: Theme.of(context)
  //                               .colorScheme
  //                               .colorBackground_SearchBox
  //                               .withOpacity(0.4),
  //                           height: 32.0,
  //                           autoFocus: true,
  //                           readOnly: false,
  //                           onTap: onTapFunc,
  //                           onPressSuffix: onPressSuffix,
  //                           onChanged: onChangedFunc,
  //                           isIconVisible: isIconVisible,
  //                           edittextController: edittextController)),
  //                 ),
  //                 Expanded(
  //                     flex: 2,
  //                     child: Container(
  //                       margin: marginBox2,
  //                       alignment: Alignment.center,
  //                       child: InkWell(
  //                         child: Container(
  //                           child: Text(
  //                             LocalizationUtil.translate("Cancel")!,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                                 fontSize: textsizeCancel,
  //                                 color: Theme.of(context)
  //                                     .colorScheme
  //                                     .colorBorder_SearchBox_Cancel),
  //                           ),
  //                         ),
  //                         onTap: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                       ),
  //                     ))
  //               ]),
  //             ],
  //           )));
  // }
}
