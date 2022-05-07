import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/create_new_bank_account.dart';
import 'package:matir_bank/view/log_in_page.dart';

import '../datatbase_helper/user_database.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late double _pageHeight;
  late double _pageWidth;
  late AppUser _appUser;
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //dbHelper = UserDatabase();
    _appUser = AppUser(password: '', userName: '');
    dbHelper.getUserData().then((result) {
      setState(() {
        _appUser = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = PageUtils.getPageWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: (_appUser == null)
                  ? null
                  : Text(
                      "Welcome User " + _appUser.userName.toString(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          SizedBox(
            height: _pageHeight * 0.02,
          ),
          SizedBox(
            width: 150,
            child: CustomButton(
              buttonHeight: 50,
              buttonName: 'Log Out',
              backgroundColor: Palette.orangeShade.shade700,
              onButtonPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInPage()),
                  (Route<dynamic> route) => false),
            ),
          ),
        ],
      ),
    );
  }
}
