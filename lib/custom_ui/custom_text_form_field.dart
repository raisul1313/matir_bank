import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matir_bank/utils/color_utils.dart';
import 'package:matir_bank/utils/values/palette.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final Color? color;
  final Color borderColor;
  final Color fillColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FocusNode? focusTo;
  final Function? validator;
  final Function? onSaved;
  final TextInputType? inputType;
  final int? maxLine;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final bool isPasswordField;
  final bool readOnly;
  final Icon? suffixIcon;
  final String? suffixText;
  final String? prefixText;
  final Icon? prefixIcon;
  final String? hint;
  bool _showPassword = false;
  bool isEnabled;
  String? initialText;
  final List<TextInputFormatter>? textInputFormatters;
  final Function? onTextChanged;
  final double? borderRadius;
  final TextAlign textAlign;
  final bool isRoundBorder;
  final bool isUnderLineBorder;

  CustomTextFormField({
    this.label,
    this.color,
    this.borderColor = Colors.black54,
    this.fillColor = Colors.white,
    this.fontSize,
    this.textEditingController,
    this.fontWeight,
    this.focusTo,
    this.validator,
    this.onSaved,
    this.inputType = TextInputType.text,
    this.maxLine = 1,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.isPasswordField = false,
    this.readOnly = false,
    this.suffixIcon,
    this.suffixText = "",
    this.prefixText = "",
    this.prefixIcon,
    this.textInputFormatters,
    this.isEnabled = true,
    this.initialText,
    this.hint,
    this.onTextChanged,
    this.borderRadius = 0,
    this.textAlign = TextAlign.start,
    this.isRoundBorder = true,
    this.isUnderLineBorder = false,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialText,
      textAlign: widget.textAlign,
      onChanged: (text) {
        if (widget.onTextChanged != null) widget.onTextChanged!(text);
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          hintText: widget.hint,
          labelText: widget.label,
          prefixIcon: widget.prefixIcon,
          labelStyle: TextStyle(
              color: widget.color,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight),
          /*focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius!)),
            borderSide:
                BorderSide(width: 1, color: Theme.of(context).primaryColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius!)),
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius!)),
            borderSide: BorderSide(width: 1, color: widget.borderColor),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius!),
              ),
              borderSide: BorderSide(
                width: 1,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius!)),
              borderSide: BorderSide(width: 1, color: Colors.black)),*/
          enabledBorder: widget.isUnderLineBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                )
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius!)),
                  borderSide: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
          focusedBorder: widget.isUnderLineBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.BANK_HEADLINE_COLOR),
                )
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRadius!)),
                  borderSide: BorderSide(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
          contentPadding: EdgeInsets.only(left: 0, right: 0, top: 10.0),
          isDense: true,
          enabled: widget.isEnabled,
          suffix: Text(
            widget.suffixText!,
            style: TextStyle(color: Colors.black87),
          ),
          prefix: Text(
            widget.prefixText!,
            style: TextStyle(color: Colors.black87),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(
                      () => widget._showPassword = !widget._showPassword,
                    );
                  },
                  icon: Icon(
                    widget._showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20.0,
                    color: widget._showPassword
                        ? Palette.orangeShade
                        : Colors.grey.shade500,
                  ),
                )
              : (widget.suffixIcon != null ? widget.suffixIcon : SizedBox())),
      keyboardType: widget.inputType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLine,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(widget.focusTo),
      onSaved: (value) {
        if (widget.onSaved != null) widget.onSaved!(value);
      },
      validator: (value) {
        if (widget.validator != null) return widget.validator!(value);
      },
      focusNode: widget.focusNode,
      controller: widget.textEditingController,
      obscureText: widget.isPasswordField ? !widget._showPassword : false,
      inputFormatters: widget.textInputFormatters,
      readOnly: widget.readOnly,
      autofocus: false,
    );
  }
}
