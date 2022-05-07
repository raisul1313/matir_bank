import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor orangeShade = MaterialColor(
    0xFFDD6E0F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFfbe9e7),
      100: Color(0xFFffccbc),
      200: Color(0xFFffab91),
      300: Color(0xFFff8a65),
      400: Color(0xFFff7043),
      500: Color(0xFFff5722),
      600: Color(0xFFf4511e),
      700: Color(0xFFe64a19),
      800: Color(0xFFd84315),
      900: Color(0xFFbf360c),
    },
  );
}
