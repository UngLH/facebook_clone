import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:flutter/material.dart';

class AppEmptyComment extends StatelessWidget {
  const AppEmptyComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.icEmptyComment,
          width: 180,
          color: AppColors.commentBackgroundColor,
        ),
        const Text(
          "Chưa có bình luận nào",
          style: TextStyle(
              color: AppColors.grayIntro,
              fontWeight: FontWeight.w400,
              fontSize: 24),
        ),
        const Text("Hãy là người đầu tiên bình luận.",
            style: TextStyle(
                color: AppColors.grayIntro,
                fontWeight: FontWeight.w400,
                fontSize: 20))
      ],
    ));
  }
}
