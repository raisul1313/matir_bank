import 'package:flutter/material.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/log_in_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: CustomButton(
                buttonHeight: 50,
                buttonName: 'Log Out',
                backgroundColor: Palette.orangeShade.shade700,
                onButtonPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LogInPage()),
                        (Route<dynamic> route) => false),
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}