import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:flutter/material.dart';

class AppEmptyListPostPage extends StatefulWidget {
  AppEmptyListPostPage({Key? key}) : super(key: key);

  @override
  State<AppEmptyListPostPage> createState() => _AppEmptyListPostPageState();
}

class _AppEmptyListPostPageState extends State<AppEmptyListPostPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
            child: Row(
              children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: AppColors.grayBackground,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      AppImages.icDefaultUser,
                      color: Colors.white,
                      width: 45,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Application.router?.navigateTo(context, Routes.addPost);
                    },
                    child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border:
                                Border.all(color: AppColors.grayBackground)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Bạn đang nghĩ gì?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  AppImages.icImage,
                  width: 30,
                )
              ],
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text("Hiện tại chưa có bài viết nào!"),
          ),
        )
      ],
    );
  }
}
