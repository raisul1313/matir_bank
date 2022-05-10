import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Profile Page",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 40,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}