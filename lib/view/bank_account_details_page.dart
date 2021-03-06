import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/values/palette.dart';

class BankAccountDetails extends StatefulWidget {
  final BankAccount bankAccount;

  const BankAccountDetails({Key? key, required this.bankAccount})
      : super(key: key);

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  final _amountFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late BankAccount _bankAccount;
  double addWithdrawAmount = 0.0;
  double updatedAmount = 0.0;

  @override
  void initState() {
    _bankAccount = BankAccount();
    getBankAccountInfo();
    setState(() {});
    super.initState();
  }

  void getBankAccountInfo() async {
    await DatabaseHelper.instance
        .getBankAccountData(widget.bankAccount.accountID!)
        .then((value) => _bankAccount = value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Details',
          style: GoogleFonts.handlee(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Account Type:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Account Number:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Branch Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Total Amount:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _bankAccount.bankName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              _bankAccount.type.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              _bankAccount.accountNumber.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              _bankAccount.branch.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              _bankAccount.amount.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "Want to add/withdraw money",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomButton(
                  buttonName: 'Add/Withdraw',
                  buttonHeight: 50,
                  backgroundColor: Palette.orangeShade.shade700,
                  onButtonPressed: _showAddWithdrawAmountDialog,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAddWithdrawAmountDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Money Add/Withdraw",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Form(
              key: _amountFormKey,
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: CustomTextFormField(
                label: "Amount",
                hint: "Enter Amount",
                borderRadius: 5,
                prefixIcon: Icon(Icons.money_rounded),
                //validator: FormValidator.validateTextForm,
                onSaved: _onNewAmountSaved,
                inputType: TextInputType.number,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                        buttonName: 'Add',
                        buttonHeight: 50,
                        backgroundColor: Palette.orangeShade.shade700,
                        onButtonPressed: _addAmount),
                  ),
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                        buttonName: 'Withdraw',
                        buttonHeight: 50,
                        backgroundColor: Palette.orangeShade.shade700,
                        onButtonPressed: _withdrawAmount),
                  ),
                ],
              )
            ],
          );
        });
  }

  _onNewAmountSaved(amount) => addWithdrawAmount = double.parse(amount);

  _addAmount() async {
    if (_amountFormKey.currentState!.validate()) {
      _amountFormKey.currentState!.save();
      updatedAmount = _bankAccount.amount! + addWithdrawAmount;
      await DatabaseHelper.instance
          .bankAccountAmountUpdate(updatedAmount, _bankAccount.accountID!);
      getBankAccountInfo();
      setState(() {});
      Navigator.pop(context);
    }
    setState(() {
      _autoValidate = true;
    });
  }

  _withdrawAmount() async {
    if (_amountFormKey.currentState!.validate()) {
      _amountFormKey.currentState!.save();
      updatedAmount = _bankAccount.amount! - addWithdrawAmount;
      await DatabaseHelper.instance.bankAccountAmountUpdate(
          updatedAmount, _bankAccount.accountID!);
      getBankAccountInfo();
      setState(() {});
      Navigator.pop(context);
    }
    setState(() {
      _autoValidate = true;
    });
  }
}
