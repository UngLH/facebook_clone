import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/ui/widgets/app_post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayBackground,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 10),
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.bottomCenter,
                      width: 50,
                      height: 50,
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
                    child: Container(
                        height: 50,
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
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
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
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, state) {
                return const AppPost();
              },
              separatorBuilder: (context, state) {
                return Container(
                  height: 10,
                  decoration:
                      const BoxDecoration(color: AppColors.grayBackground),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
