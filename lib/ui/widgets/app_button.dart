import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Color color;
  Color? splashColor;
  String? title;
  TextStyle? textStyle;
  double? height;
  double? width;
  VoidCallback? onPressed;
  Widget? child;
  bool isLoading;
  bool isEnabled;
  double? border;

  AppButton(
      {Key? key,
      this.title,
      required this.color,
      this.splashColor,
      this.child,
      this.onPressed,
      this.textStyle,
      this.height,
      this.isLoading = false,
      this.isEnabled = true,
      this.width,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(width ?? 80),
          backgroundColor: isEnabled ? color : const Color(0xFFCBCBCB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border ?? 16),
          )),
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: FittedBox(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            )
          : child ??
              Text(
                title!,
                style: textStyle ??
                    AppTextStyle.whiteS14Bold.copyWith(
                        fontFamily: "Roboto", fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
    );
    //  InkWell(
    //   onTap: isEnabled ? onPressed : null,
    //   splashColor: splashColor ??  AppColors.blue5B,
    //   child: Container(
    //     height: height ?? 40,
    //     width: width ?? 80,
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(
    //       color: isEnabled ? color : const Color(0xFFCBCBCB),
    //       borderRadius: BorderRadius.circular(border ?? 16),
    //     ),
    //     child: isLoading
    //         ? const Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5),
    //       child: FittedBox(
    //           child: CircularProgressIndicator(
    //             color: Colors.white,
    //           )),
    //     )
    //         : child ??
    //         Text(
    //           title!,
    //           style: textStyle ?? AppTextStyle.whiteS14Bold.copyWith(fontFamily: "Roboto", fontWeight: FontWeight.w800),
    //           textAlign: TextAlign.center,
    //         ),
    //   ),
    // );
  }
}
