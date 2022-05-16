import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBankAccount extends StatefulWidget {
  const CreateBankAccount({Key? key}) : super(key: key);

  @override
  State<CreateBankAccount> createState() => _CreateBankAccountState();
}

class _CreateBankAccountState extends State<CreateBankAccount> {
  final _createBankAccountFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late double _pageHeight;
  late double _pageWidth;
  late BankAccount _bankAccount;
  late int id;
  late String _selectAccountType;
  int _radioGroupValue = 1;

  @override
  void initState() {
    _bankAccount = BankAccount();
    _getUserID();
    _selectAccountType = "Current Account";
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
    _pageWidth = PageUtils.getPageWidth(context);
    return buildBottomSheet();
  }

  Widget buildBottomSheet() {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: _pageHeight,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Create New Bank Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  color: Palette.orangeShade.shade700,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                Form(
                  key: _createBankAccountFormKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      CustomTextFormField(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAccountNoSaved(accountNo) => _bankAccount.accountNumber = accountNo;

  _onBankNameNoSaved(bankName) => _bankAccount.bankName = bankName;

  _onBranchNameSaved(branchName) => _bankAccount.branch = branchName;

  _onInitialAmountSaved(initialAmount) =>_bankAccount.amount = double.parse(initialAmount);

  createAccount() async {
    if (_createBankAccountFormKey.currentState!.validate()) {
      _createBankAccountFormKey.currentState!.save();
      _bankAccount.type = _selectAccountType;
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
