import 'package:flutter/material.dart';
import 'package:matir_bank/utils/color_utils.dart';

class CustomHeader extends StatelessWidget {
  final String headerName;
  final double marginTop;
  final double marginBottom;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double marginLeft;
  final double marginRight;

  CustomHeader({
    required this.headerName,
    this.marginTop = 10,
    this.marginBottom = 10,
    this.fontSize,
    this.fontWeight,
    this.color = ColorUtils.BANK_BLUE,
    this.textAlign,
    this.marginLeft = 0,
    this.marginRight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginLeft,
        right: marginRight,
      ),
      child: Column(
        children: [
          SizedBox(height: marginTop),
          Text(
            headerName,
            style: TextStyle(
                color: color, fontSize: fontSize, fontWeight: fontWeight),
            textAlign: textAlign,
          ),
          SizedBox(height: marginBottom),
        ],
      ),
    );
  }
}
