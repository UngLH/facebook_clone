import 'package:facebook/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
    bool showBackButton = true,
    required BuildContext context,
    VoidCallback? onBackPressed,
    String title = "",
    Color? backgroundColor,
    List<Widget> rightActions = const [],
  }) : super(
          key: key,
          centerTitle: false,
          shape: const Border(
              bottom: BorderSide(color: AppColors.borderColor, width: 1)),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
          backgroundColor: backgroundColor ?? AppColors.background,
          leading: showBackButton
              ? IconButton(
                  onPressed: onBackPressed ??
                      () {
                        Navigator.of(context).pop(true);
                      },
                  icon:
                      const Icon(Icons.keyboard_backspace, color: Colors.black))
              : null,
          actions: rightActions,
        );
}
