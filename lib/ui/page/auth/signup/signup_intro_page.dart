import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/widgets/app_bar.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SignUpIntroPage extends StatefulWidget {
  const SignUpIntroPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpIntroPageState();
  }
}

class _SignUpIntroPageState extends State<SignUpIntroPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context, title: "Tạo tài khoản"),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.icSignupIntro,
                    width: 220,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Tham gia Facebook",
                    style: AppTextStyle.blackS18Bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Chúng tôi sẽ giúp bạn tạo tài khoản sau vài bước dễ dàng.",
                    style: AppTextStyle.blackS16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  AppButton(
                    title: "Tiếp",
                    onPressed: () {
                      Application.router
                          ?.navigateTo(context, Routes.signUpName);
                    },
                  )
                ],
              ),
            ),
            const Text(
              "Bạn đã có tài khoản ư?",
              style:
                  TextStyle(color: AppColors.main, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
