import 'package:facebook/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldUnderLine extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final FormFieldSetter<String>? onSaved;
  final bool? isRequire;
  final TextStyle? labelStyle;
  final AutovalidateMode? autoValidateMode;
  final String? initialValue;
  final bool? enable;

  const AppTextFieldUnderLine({
    Key? key,
    this.initialValue,
    this.labelText = '',
    this.prefixIcon,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    this.autoValidateMode,
    this.validator,
    this.onSaved,
    this.isRequire,
    this.labelStyle,
    this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            enabled: enable,
            controller: controller,

            decoration: InputDecoration(
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              hintText: hintText,
              labelText: labelText,
              contentPadding:
                  const EdgeInsets.only(left: 2, right: 2, bottom: 12),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkMain),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkMain, width: 2),
              ),
              // hintStyle: AppTextStyle.greyS16,
            ),
            initialValue: initialValue,
            autovalidateMode: autoValidateMode,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            // style: AppTextStyle.blackS14,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}

class AppPasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final FormFieldSetter<String>? onSaved;
  final bool? isRequire;
  final bool? enable;
  final TextStyle? labelStyle;
  final AutovalidateMode? autoValidateMode;
  final String? initialValue;
  final bool? obscureText;
  final Widget? suffixIcon;
  final double? padding;

  const AppPasswordField(
      {Key? key,
      this.initialValue,
      this.labelText = '',
      this.hintText = '',
      this.controller,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.autoValidateMode,
      this.validator,
      this.onSaved,
      this.isRequire,
      this.labelStyle,
      this.enable,
      this.obscureText = false,
      this.suffixIcon,
      this.padding})
      : super(key: key);

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowPassword = false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 30),
      child: TextFormField(
        obscureText: widget.obscureText!,
        obscuringCharacter: "*",
        enabled: widget.enable,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.only(left: 2, right: 2, bottom: 0),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkMain),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkMain, width: 2),
          ),
          // focusedErrorBorder: OutlineInputBorder(
          //   // borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: AppColors.lineGray),
          // ),
          // hintStyle: AppTextStyle.greyS16,
          // isDense: true,
        ),
        initialValue: widget.initialValue,
        autovalidateMode: widget.autoValidateMode,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        // style: AppTextStyle.blackS16,
        onSaved: widget.onSaved,
      ),
    );
  }
}
