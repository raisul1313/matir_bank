import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/custom_ui/custom_account_item.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/bank_account_details_page.dart';
import 'package:matir_bank/view/create_bank_account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late double _pageHeight;
  late double _pageWidth;
  late List<BankAccount> _bankAccountList;

  @override
  void initState() {
    _bankAccountList = [];
    getBankAccountInfo();
    super.initState();
  }

  void getBankAccountInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await DatabaseHelper.instance
        .getListBankAccountData(prefs.getInt('id')!)
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
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.handlee(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
        ),
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
              builder: (context) => CreateBankAccount());
          Fluttertoast.showToast(
              msg: "Create new bank account",
              backgroundColor: Palette.orangeShade);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        height: _pageHeight,
        width: _pageWidth,
        color: Colors.grey.shade200,
        child: _bankAccountList.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [_getAccountListWidget()],
                ),
              )
            : Center(
                child: Text(
                  "No Account Found !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Palette.orangeShade.shade900,
                  ),
                ),
              ),
      ),
    );
  }

  _getAccountListWidget() {
    return ListView.builder(
      itemCount: _bankAccountList.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(5.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('EditP'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('DeleteP'),
                  )
                ];
              },
            );
          },
          child: ItemAccount(
            bankAccount: _bankAccountList[index],
            itemClick: _onItemClicked,
            itemLongClick: _onItemLongClicked,
          ),
        );
      },
    );
  }

  _onItemClicked(BankAccount bankAccount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankAccountDetails(
          bankAccount: bankAccount,
        ),
      ),
    );
  }

  _onItemLongClicked(BankAccount bankAccount) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
      //position where you want to show the menu on screen
      items: [
        PopupMenuItem(child: const Text('Edit'), value: 1),
        PopupMenuItem(child: const Text('Delete'), value: 2),
      ],
    );
  }
}
