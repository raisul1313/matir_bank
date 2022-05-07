import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';

class CreateNewBankAccount extends StatefulWidget {
  const CreateNewBankAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewBankAccount> createState() => _CreateNewBankAccountState();
}

class _CreateNewBankAccountState extends State<CreateNewBankAccount> {
  late double _pageHeight;
  late double _pageWidth;
  final _createBankAccountFormKey = GlobalKey<FormState>();
  final bool _autoValidate = false;

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
                CustomTextFormField(
                  label: "Name",
                  hint: "Enter Name",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.person),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onNameSaved,
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                CustomTextFormField(
                  label: "Address",
                  hint: "Enter Address",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.home),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onNameSaved,
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
                  //onSaved: _onNameSaved,
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                CustomTextFormField(
                  label: "Date of Birth",
                  hint: "Enter Date of Birth",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.date_range),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onNameSaved,
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                CustomTextFormField(
                  label: "Phone Number",
                  hint: "Enter Phone Number",
                  borderRadius: 5,
                  prefixIcon: Icon(Icons.phone),
                  //validator: FormValidator.validateTextForm,
                  //onSaved: _onNameSaved,
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: _pageHeight * 0.02,
                ),
                CustomTextFormField(
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
                ),
                SizedBox(
                  width: 150,
                  child: CustomButton(
                    buttonHeight: 50,
                    buttonName: 'Submit',
                    backgroundColor: Palette.orangeShade.shade700,
                    onButtonPressed: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: "New bank account successfully created",
                        backgroundColor: Palette.orangeShade,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
