import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/datatbase_helper/database_helper.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/log_in_page.dart';
import 'package:matir_bank/view/registration_profile_update_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AppUser _appUser;

  @override
  void initState() {
    _appUser = AppUser();
    getUserInfo();
    setState(() {});
    super.initState();
  }

  void getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await DatabaseHelper.instance
        .getUserData(prefs.getInt('id')!)
        .then((value) => _appUser = value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Details',
          style: GoogleFonts.handlee(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Full Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Father's Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Mother's Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Address:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Phone Number:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Birthday Date:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Palette.orangeShade),
                        ),
                        Text(
                          "Gender:",
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
                          _appUser.userName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.fullName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.fatherName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.motherName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.address.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.phoneNumber.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.birthDate.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        Text(
                          _appUser.gender.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                        buttonName: 'Edit',
                        buttonHeight: 50,
                        backgroundColor: Palette.orangeShade.shade700,
                        onButtonPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegistrationProfileUpdatePage(
                              isUpdate: true,
                              existingUser: _appUser,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                        buttonName: 'Delete',
                        buttonHeight: 50,
                        backgroundColor: Palette.orangeShade.shade700,
                        onButtonPressed: () async {
                          await showDeleteUserDialog();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteUserDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete Account !",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeShade.shade900),
            ),
            content: const Text(
                "Are you sure that you want to delete your account ?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => _userDelete(),
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  _userDelete() async {
    await DatabaseHelper.instance.userDelete(_appUser.userID!);
    await DatabaseHelper.instance.bankAccountsDeleteByUser(_appUser.userID!);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Your account is deleted.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeShade.shade900),
            ),
            content: const Text(
                "Please Log In First"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LogInPage()),
                        (Route<dynamic> route) => false),
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }
}
