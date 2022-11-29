import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Color? color;
  Color? splashColor;
  String? title;
  TextStyle? textStyle;
  double? height;
  double? width;
  VoidCallback? onPressed;
  Widget? child;
  double? border;

  AppButton(
      {Key? key,
      this.title,
      this.color,
      this.splashColor,
      this.child,
      this.onPressed,
      this.textStyle,
      this.height,
      this.width,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(width ?? MediaQuery.of(context).size.width),
          backgroundColor: color ?? const Color(0xFF1877f2),
          // disabledBackgroundColor: const Color(0xFF1877f2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border ?? 5),
          )),
      child: Text(
        title!,
        style: textStyle ??
            AppTextStyle.whiteS14.copyWith(
              fontFamily: "Roboto",
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AppRoundIconButton extends StatelessWidget {
  IconData iconData;
  VoidCallback? onPressed;

  AppRoundIconButton({Key? key, required this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.roundIconButtonBackground,
        ),
        child: Center(
          child: Icon(
            iconData,
            color: Colors.black,
            size: 26,
          ),
        ));
  }
}
