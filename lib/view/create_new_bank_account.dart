import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';

class CreateNewBankAccount extends StatefulWidget {
  const CreateNewBankAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewBankAccount> createState() => _CreateNewBankAccountState();
}

class _CreateNewBankAccountState extends State<CreateNewBankAccount> {
  final _createBankAccountFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late double _pageHeight;
  late double _pageWidth;
  late BankAccount _bankAccount;

  @override
  void initState() {
    super.initState();
    _bankAccount = BankAccount();
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
                      'Create new Bank Account',
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
                        label: "Account No.",
                        hint: "Enter Account No.",
                        borderRadius: 5,
                        prefixIcon: Icon(Icons.apartment),
                        //validator: FormValidator.validateTextForm,
                        onSaved: _onAccountNoSaved,
                        inputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: _pageHeight * 0.02,
                      ),
                      CustomTextFormField(
                        label: "Branch Name",
                        hint: "Enter Branch Name",
                        borderRadius: 5,
                        prefixIcon: Icon(Icons.apartment),
                        //validator: FormValidator.validateTextForm,
                        onSaved: _onBranchNameSaved,
                        inputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: _pageHeight * 0.02,
                      ),
                      CustomTextFormField(
                        label: "Amount",
                        hint: "Enter Initial Amount",
                        borderRadius: 5,
                        prefixIcon: Icon(Icons.apartment),
                        //validator: FormValidator.validateTextForm,
                        onSaved: _onInitialAmountSaved,
                        inputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: _pageHeight * 0.02,
                      ),
                      CustomTextFormField(
                        label: "Account Type",
                        hint: "Enter Account Type",
                        borderRadius: 5,
                        prefixIcon: Icon(Icons.apartment),
                        //validator: FormValidator.validateTextForm,
                        onSaved: _onAccountTypeSaved,
                        inputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      /*CustomTextFormField(
                  label: "Pin",
                  hint: "Enter Pin",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.apps),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onPassSaved,
                  inputType: TextInputType.number,
                  isPasswordField: true,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                CustomTextFormField(
                  label: "Confirm Pin",
                  hint: "Re-type Pin",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.apps),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onPassSaved,
                  inputType: TextInputType.number,
                  isPasswordField: true,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),*/
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

  _onBranchNameSaved(branchName) => _bankAccount.branch = branchName;

  _onInitialAmountSaved(initialAmount) => _bankAccount.amount = initialAmount;

  _onAccountTypeSaved(accountType) => _bankAccount.type = accountType;

  createAccount() async {
    if (_createBankAccountFormKey.currentState!.validate()) {
      _createBankAccountFormKey.currentState!.save();
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
        Navigator.pop(context);
      });
    }
    setState(() {
      _autoValidate = true;
    });
  }
}
