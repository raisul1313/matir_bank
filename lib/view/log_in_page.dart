import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/landing_page.dart';
import 'package:matir_bank/view/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late List<AppUser> appUserList;
  late String userNameLog;
  late String passwordLog;

  late double _pageHeight;
  late double _pageWidth;
  final _loginFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    appUserList = [];
    userNameLog = '';
    passwordLog = '';
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = PageUtils.getPageWidth(context);
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _pageHeight * 0.07,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/matir_bank.png',
                      height: 150,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Welcome",
                    style: GoogleFonts.handlee(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Palette.orangeShade.shade700),
                  ),
                  Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: _pageHeight * 0.01,
                  ),
                  Form(
                    key: _loginFormKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        CustomTextFormField(
                          label: "User ID",
                          hint: "Enter User ID",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          onSaved: _onUserNameSaved,
                          inputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          label: "Password",
                          hint: "Enter Password",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.password),
                          //validator: FormValidator.validateTextForm,
                          onSaved: _onPassSaved,
                          inputType: TextInputType.name,
                          isPasswordField: true,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: _pageHeight * 0.03,
                        ),
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            buttonName: 'Login',
                            buttonHeight: 50,
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: logIn,
                          ),
                        ),
                        SizedBox(
                          height: _pageHeight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(
                          height: _pageHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Not Registered? "),
                            InkWell(
                              child: Text(
                                " Sign Up",
                                style: TextStyle(
                                  color: Palette.orangeShade.shade700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationPage()),
                                );
                                Fluttertoast.showToast(
                                  msg: "Registration page",
                                  backgroundColor: Palette.orangeShade,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: _pageHeight * 0.2,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: appUserList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == appUserList.length) {
                          return CustomButton(
                            buttonName: 'Refresh',
                            buttonHeight: 50,
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: () {
                              setState(() {
                                _queryAll();
                              });
                            },
                          );
                        }
                        return Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'ID: ${appUserList[index].userID} Name: ${appUserList[index].userName} Pass: ${appUserList[index].password}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
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

  _onUserNameSaved(userName) => userNameLog = userName;

  _onPassSaved(password) => passwordLog = password;

  logIn() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      await DatabaseHelper.instance
          .getLoginUser(userNameLog, passwordLog)
          .then((userData) {
        if (userData.userName != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LandingPage(),
                ),
                (Route<dynamic> route) => false);
          });
        }
      }).catchError((error) {
        print(error);
        Fluttertoast.showToast(
          msg: "Login Fail",
          backgroundColor: Palette.orangeShade,
        );
      });
    }
    setState(() {
      _autoValidate = true;
    });
  }

  Future setSP(AppUser appUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", appUser.userID!);
  }

  void _queryAll() async {
    appUserList = await DatabaseHelper.instance.showAllData();
  }
}
