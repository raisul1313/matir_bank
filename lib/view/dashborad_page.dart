import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_account_item.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/create_new_bank_account.dart';
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
  late BankAccount _bankAccount;
  late int id;
  late List<BankAccount> _bankAccountList;

  @override
  void initState() {
    super.initState();
    _appUser = AppUser();
    _bankAccount = BankAccount();
    _bankAccountList = [];
    //getUserInfo();
    getBankAccountInfo();
  }

  /* void getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await DatabaseHelper.instance
        .getUserData(prefs.getInt('id')!)
        .then((value) => _appUser = value);
  }*/

  void getBankAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await DatabaseHelper.instance
        .getBankAccountData(prefs.getInt('id')!)
        .then((value) {
      _bankAccountList = value;
      setState(() {});
    });
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
      body: Container(
        height: _pageHeight,
        width: _pageWidth,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [_getAccountListWidget()],
          ),
        ),
      ),
    );
  }

  _getAccountListWidget() {
    return _bankAccountList.isNotEmpty
        ? ListView.builder(
            itemCount: _bankAccountList.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ItemAccount(
                bankAccount: _bankAccountList[index],
              );
            },
          )
        : Center(child: Text('No Account Found'));
  }
}
