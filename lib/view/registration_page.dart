import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/user_database.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/log_in_page.dart';

class RegistrationPage extends StatefulWidget {
  final AppUser? appUser;

  const RegistrationPage({Key? key, this.appUser}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _registrationFormKey = GlobalKey<FormState>();
  late double _pageHeight;
  late double _pageWidth;
  bool _autoValidate = false;

  //late AppUser _appUser;
  // var dbHelper;

  late String userNameReg;
  late String passwordReg;

  @override
  void initState() {
    super.initState();
    // dbHelper = UserDatabase();
    userNameReg = widget.appUser?.userName ?? '';
    passwordReg = widget.appUser?.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = PageUtils.getPageWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: _pageHeight,
          width: _pageWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: _pageHeight * 0.01,
                  ),
                  Form(
                    key: _registrationFormKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        /*  SizedBox(
                          height: 10.0,
                        ),
                        CustomTextFormField(
                          label: "User ID",
                          hint: "Enter User ID",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onNewUserIDSaved,
                          textInputAction: TextInputAction.next,
                        ),*/
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          label: "Name",
                          hint: "Enter Name",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onNewUserNameSaved,
                          textInputAction: TextInputAction.next,
                        ),

                        /*SizedBox(
                          height: 20.0,
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
                          height: 20.0,
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
                        ),*/
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          label: "Password",
                          hint: "Enter Password",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.password),
                          //validator: FormValidator.validateTextForm,
                          onSaved: _onNewPassSaved,
                          inputType: TextInputType.name,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        /*CustomTextFormField(
                          label: "Confirm Password",
                          hint: "Re-type Password",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.password),
                          //validator: FormValidator.validateTextForm,
                          //onSaved: _onPassSaved,
                          inputType: TextInputType.name,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: _pageHeight * 0.03,
                        ),*/
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            buttonHeight: 50,
                            buttonName: 'Register',
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: signUp,
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
      ),
    );
  }

  _onNewUserNameSaved(newUserName) => userNameReg = newUserName;

  _onNewPassSaved(newPassword) => passwordReg = newPassword;

  signUp() async {
    if (_registrationFormKey.currentState!.validate()) {
      _registrationFormKey.currentState!.save();
      final appUser = AppUser(userName: userNameReg, password: passwordReg);
      await UserDatabase.instance.create(appUser);
      print(appUser.userName);
      print(appUser.password);
      Fluttertoast.showToast(
        msg: "Successfully Saved",
        backgroundColor: Palette.orangeShade,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    } else {
      Fluttertoast.showToast(
        msg: "Successfully Saved",
        backgroundColor: Palette.orangeShade,
      );
    }
    setState(() {
      _autoValidate = true;
    });
  }
}
