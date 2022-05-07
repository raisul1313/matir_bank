import 'package:flutter/material.dart';
import 'package:matir_bank/utils/color_utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool isCenterTitle;
  final bool showLeadingBackButton;
  final List<Widget>? actions;

  CustomAppBar({
    this.title = "",
    this.isCenterTitle = true,
    this.showLeadingBackButton = false,
    this.actions,
    Key? key,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(color: ColorUtils.BANK_HEADLINE_COLOR),
        ),
        centerTitle: isCenterTitle,
        backgroundColor: ColorUtils.BANK_BACKGROUND,
        elevation: 2.0,
        leading:
            showLeadingBackButton ? _customBackButton() : SizedBox.shrink(),
        actions: actions);
  }

  Widget _customBackButton() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back,
              color: ColorUtils.BANK_HEADLINE_COLOR, size: 25.0),
          onPressed: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
