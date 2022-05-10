import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/create_new_bank_account.dart';
import 'package:matir_bank/view/log_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late double _pageHeight;
  late double _pageWidth;
  late AppUser _appUser;
  late int id;

  @override
  void initState() {
    super.initState();
    _appUser = AppUser();
    getUserInfo();
  }

  void getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await DatabaseHelper.instance
        .getUserData(prefs.getInt('id')!)
        .then((value) => _appUser = value);
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = PageUtils.getPageWidth(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.orangeShade.shade700,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              //enableDrag: false,
              //isDismissible: false,
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              builder: (context) => CreateNewBankAccount());
          Fluttertoast.showToast(
              msg: "Create new bank account",
              backgroundColor: Palette.orangeShade,
              textColor: Colors.black);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Text(
                "Welcome " + _appUser.userName.toString(),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
