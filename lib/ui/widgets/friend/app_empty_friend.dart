import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:flutter/material.dart';

class AppEmptyFriend extends StatelessWidget {
  const AppEmptyFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.icEmptyFriend,
          width: 180,
          color: AppColors.commentBackgroundColor,
        ),
        const Text(
          "Chưa có bạn bè nào",
          style: TextStyle(
              color: AppColors.grayIntro,
              fontWeight: FontWeight.w400,
              fontSize: 24),
        ),
      ],
    ));
  }
}
