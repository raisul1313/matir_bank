import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matir_bank/utils/values/palette.dart';
import 'package:matir_bank/view/log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matir Bank',
      theme: ThemeData(
        primaryColor: Palette.orangeShade,
        primarySwatch: Palette.orangeShade,
        unselectedWidgetColor: Palette.orangeShade,
      ),
      home: LogInPage(),
    );
  }
}
