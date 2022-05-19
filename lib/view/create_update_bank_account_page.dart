import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUpdateBankAccount extends StatefulWidget {
  final BankAccount? existBankAccount;
  final bool isUpdate;

  const CreateUpdateBankAccount(
      {Key? key, this.existBankAccount, required this.isUpdate})
      : super(key: key);

  @override
  State<CreateUpdateBankAccount> createState() => _CreateUpdateBankAccountState();
}

class _CreateUpdateBankAccountState extends State<CreateUpdateBankAccount> {
  final _createBankAccountFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late double _pageHeight;
  late double _pageWidth;
  late BankAccount _bankAccount;
  late int id;
  late String _selectAccountType = "Current Account";
  int _radioGroupValue = 1;

  @override
  void initState() {
    _bankAccount = (widget.isUpdate ? widget.existBankAccount : BankAccount())!;
    if (widget.isUpdate) {
      switch (widget.existBankAccount!.type) {
        case 'Current Account':
          _radioGroupValue = 1;
          break;
        case 'Saving Account':
          _radioGroupValue = 2;
          break;
        case 'Fixed Deposit Account':
          _radioGroupValue = 3;
          break;
      }
    }
    _selectAccountType =
        (widget.isUpdate ? widget.existBankAccount!.type : "Current Account")!;
    _getUserID();
    super.initState();
  }

  void _getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id")!;
    _bankAccount.userID = id;
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Bank Account',
          style: GoogleFonts.handlee(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: _pageHeight,
            width: _pageWidth,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _createBankAccountFormKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    CustomTextFormField(
                      initialText: widget.isUpdate
                          ? widget.existBankAccount!.bankName
                          : '',
                      label: "Bank Name",
                      hint: "Enter Bank Name",
                      borderRadius: 5,
                      prefixIcon: Icon(Icons.account_circle),
                      //validator: FormValidator.validateTextForm,
                      onSaved: _onBankNameNoSaved,
                      inputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: _pageHeight * 0.02,
                    ),
                    CustomTextFormField(
                      initialText: widget.isUpdate
                          ? widget.existBankAccount!.accountNumber
                          : '',
                      label: "Account No.",
                      hint: "Enter Account No.",
                      borderRadius: 5,
                      prefixIcon: Icon(Icons.account_circle),
                      //validator: FormValidator.validateTextForm,
                      onSaved: _onAccountNoSaved,
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: _pageHeight * 0.02,
                    ),
                    CustomTextFormField(
                      initialText: widget.isUpdate
                          ? widget.existBankAccount!.branch
                          : '',
                      label: "Branch Name",
                      hint: "Enter Branch Name",
                      borderRadius: 5,
                      prefixIcon: Icon(Icons.account_balance_sharp),
                      //validator: FormValidator.validateTextForm,
                      onSaved: _onBranchNameSaved,
                      inputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: _pageHeight * 0.02,
                    ),
                    CustomTextFormField(
                      initialText: widget.isUpdate
                          ? widget.existBankAccount!.amount.toString()
                          : '',
                      label: "Initial Amount",
                      hint: "Enter Initial Amount",
                      borderRadius: 5,
                      prefixIcon: Icon(Icons.add),
                      //validator: FormValidator.validateTextForm,
                      onSaved: _onInitialAmountSaved,
                      inputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: _pageHeight * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Bank Account: ",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Current Account"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Saving Account"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 3,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Fixed Deposit Account"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                        buttonHeight: 50,
                        buttonName: 'Submit',
                        backgroundColor: Palette.orangeShade.shade700,
                        onButtonPressed: createAccount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onAccountNoSaved(accountNo) => _bankAccount.accountNumber = accountNo;

  _onBankNameNoSaved(bankName) => _bankAccount.bankName = bankName;

  _onBranchNameSaved(branchName) => _bankAccount.branch = branchName;

  _onInitialAmountSaved(initialAmount) =>
      _bankAccount.amount = double.parse(initialAmount);

  createAccount() async {
    if (_createBankAccountFormKey.currentState!.validate()) {
      _createBankAccountFormKey.currentState!.save();
      _bankAccount.type = _selectAccountType;
      if (widget.isUpdate) {
        await DatabaseHelper.instance.bankAccountDetailsUpdate(_bankAccount);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LandingPage()),
            (Route<dynamic> route) => false);
      } else {
        await DatabaseHelper.instance
            .createNewBankAccount(_bankAccount)
            .then((value) {
          if (value) {
            Fluttertoast.showToast(
              msg: "New Account Saved",
              backgroundColor: Palette.orangeShade,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Not Successful !!!",
              backgroundColor: Palette.orangeShade,
            );
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => LandingPage(),
              ),
              (Route<dynamic> route) => false);
        });
      }
    }
    setState(() {
      _autoValidate = true;
    });
  }

  _handleRadioValue(value) {
    switch (value) {
      case 1:
        setState(() {
          _radioGroupValue = value;
          _selectAccountType = "Current Account";
        });

        break;
      case 2:
        setState(() {
          _radioGroupValue = value;
          _selectAccountType = "Saving Account";
        });
        break;
      case 3:
        setState(() {
          _radioGroupValue = value;
          _selectAccountType = "Fixed Deposit Account";
        });
        break;
    }
  }
}
