import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/page_utils.dart';
import 'package:matir_bank/view/dashborad_page.dart';
import 'package:matir_bank/view/profile_page.dart';
import 'package:matir_bank/view/setting_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIndex = 0;
  final pages = [
    const DashboardPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildNavBar(context),
    );
  }

  Container buildNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.widgets_rounded,
              color: Colors.black,
                    size: 30,
                  )
                : const Icon(
                    Icons.widgets_outlined,
              color: Colors.black,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.person,
              color: Colors.black,
                    size: 30,
                  )
                : const Icon(
                    Icons.person_outline,
              color: Colors.black,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.workspaces_filled,
                    color: Colors.black,
                    size: 30,
                  )
                : const Icon(
                    Icons.workspaces_outline,
                    color: Colors.black,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }
}
