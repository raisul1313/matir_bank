import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/custom_ui/custom_text_form_field.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/landing_page.dart';
import 'package:matir_bank/view/log_in_page.dart';


class RegistrationProfileUpdatePage extends StatefulWidget {
  final AppUser? existingUser;
  final bool isUpdate;

  const RegistrationProfileUpdatePage({Key? key, this.existingUser, required this.isUpdate})
      : super(key: key);

  @override
  State<RegistrationProfileUpdatePage> createState() => _RegistrationProfileUpdatePageState();
}

class _RegistrationProfileUpdatePageState extends State<RegistrationProfileUpdatePage> {
  final _registrationFormKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late double _pageHeight;
  late double _pageWidth;
  late AppUser _appUser;
  late String todayDate;
  late String birthDate;
  DateTime showingDate = DateTime.now();
  var outputFormat = DateFormat('dd/MM/yyyy');
  int _radioGroupValue = 1;
  String _selectedGender = "Male";

  @override
  void initState() {
    super.initState();
    _appUser = widget.isUpdate ? widget.existingUser! : AppUser();
    if (widget.isUpdate) {
      switch (widget.existingUser!.gender) {
        case 'Male':
          _radioGroupValue = 1;
          break;
        case 'Female':
          _radioGroupValue = 2;
          break;
        case 'Other':
          _radioGroupValue = 3;
      }
    }
    birthDate = (widget.isUpdate
        ? widget.existingUser!.birthDate
        : outputFormat.format(showingDate))!;
    _appUser.birthDate = birthDate;
    _selectedGender = (widget.isUpdate ? widget.existingUser!.gender : "Male")!;
  }

  @override
  Widget build(BuildContext context) {
    _pageHeight = MediaQuery.of(context).size.height;
    _pageWidth = PageUtils.getPageWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
          style: GoogleFonts.handlee(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
        ),
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
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.userName
                              : '',
                          label: "User Name",
                          hint: "Enter User Name",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onNewUserNameSaved,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.fullName
                              : '',
                          label: "Full Name",
                          hint: "Enter Full Name",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onFullNameSaved,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.fatherName
                              : '',
                          label: "Father's Name",
                          hint: "Enter Father's Name",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onFatherNameSaved,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.motherName
                              : '',
                          label: "Mother's Name",
                          hint: "Enter Mother's Name",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.person),
                          //validator: FormValidator.validateTextForm,
                          inputType: TextInputType.name,
                          isUnderLineBorder: false,
                          isRoundBorder: true,
                          onSaved: _onMotherNameSaved,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.address
                              : '',
                          label: "Address",
                          hint: "Enter Address",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.home),
                          //validator: FormValidator.validateTextForm,
                          onSaved: _onAddressSaved,
                          inputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.phoneNumber
                              : '',
                          label: "Phone Number",
                          hint: "Enter Phone Number",
                          borderRadius: 5,
                          prefixIcon: Icon(Icons.phone),
                          //validator: FormValidator.validateTextForm,
                          onSaved: _onPhoneNumberSaved,
                          inputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: _pageHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Colors.black54)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Palette.orangeShade.shade700,
                                    //size: 20,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      birthDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _pageHeight * 0.02,
                        ),
                        Row(
                          children: [
                            Text(
                              "Gender: ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Male"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Female"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 3,
                                    groupValue: _radioGroupValue,
                                    onChanged: _handleRadioValue),
                                Text("Other"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextFormField(
                          initialText: widget.isUpdate
                              ? widget.existingUser!.password
                              : '',
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
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            buttonHeight: 50,
                            buttonName: 'Submit',
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: upDateSignUp,
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

  _onNewUserNameSaved(newUserName) => _appUser.userName = newUserName;

  _onFullNameSaved(fullName) => _appUser.fullName = fullName;

  _onFatherNameSaved(fatherName) => _appUser.fatherName = fatherName;

  _onMotherNameSaved(motherName) => _appUser.motherName = motherName;

  _onAddressSaved(address) => _appUser.address = address;

  _onPhoneNumberSaved(phoneNumber) => _appUser.phoneNumber = phoneNumber;

  _onNewPassSaved(newPassword) => _appUser.password = newPassword;

  upDateSignUp() async {
    if (_registrationFormKey.currentState!.validate()) {
      _registrationFormKey.currentState!.save();
      _appUser.gender = _selectedGender;
      if (widget.isUpdate) {
        await DatabaseHelper.instance.userDetailsUpdate(_appUser);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => LandingPage(),
            ),
                (Route<dynamic> route) => false);
      } else {
        await DatabaseHelper.instance.register(_appUser).then((value) {
          if (value) {
            Fluttertoast.showToast(
              msg: "Successfully Saved",
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
    }
    setState(() {
      _autoValidate = true;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: showingDate, // Refer step 1
      firstDate: DateTime(1000),
      lastDate: DateTime(5000),
    ))!;

    if (picked != null && picked != showingDate) {
      setState(() {
        showingDate = picked;
        birthDate = outputFormat.format(showingDate);
        _appUser.birthDate = birthDate;
      });
    }
  }

  _handleRadioValue(value) {
    switch (value) {
      case 1:
        setState(() {
          _radioGroupValue = value;
          _selectedGender = "Male";
        });

        break;
      case 2:
        setState(() {
          _radioGroupValue = value;
          _selectedGender = "Female";
        });
        break;
      case 3:
        setState(() {
          _radioGroupValue = value;
          _selectedGender = "Other";
        });
        break;
    }
  }
}
