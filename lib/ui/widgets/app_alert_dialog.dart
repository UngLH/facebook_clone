import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  String? title;
  String? information;
  VoidCallback? onConfirm;

  AppAlertDialog({
    Key? key,
    required this.onConfirm,
    this.title,
    this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Center(
                    child: Text('Không có kết nối Internet',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 22)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Không thể sử dụng dịch vụ. Vui lòng kiểm tra kết nối của bạn và thử lại!',
                    style: AppTextStyle.blackS16
                        .copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onConfirm,
                  child: const Text(
                    'Thử lại',
                    style: TextStyle(
                        color: AppColors.blue5B,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
