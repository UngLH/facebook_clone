import 'package:facebook/commons/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  final String? message;

  AppSnackBar({
    Key? key,
    this.message,
  }) : super(
          key: key,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.snackBarBackground),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(message ?? "Có lỗi xảy ra",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      )),
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.all(28),
          backgroundColor: Colors.transparent,
        );
}
