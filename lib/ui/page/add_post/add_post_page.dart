import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddPostPageState();
  }
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          elevation: 1,
          title: const Text(
            "Tạo bài viết",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: AppColors.background,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                  onPressed: () {
                    print("Đăng");
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(60),
                      backgroundColor: AppColors.main,
                      elevation: 1),
                  child: const Text("Đăng")),
            ),
          ],
        ),
        body: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          width: 10,
                        ),
                        Text(
                          "Lê Hồng Ưng",
                          style: AppTextStyle.blackS16Bold,
                        )
                      ],
                    ),
                  ),
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 10,
                    cursorHeight: 25,
                    cursorColor: AppColors.blueIconButton,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 0),
                        hintText: "Bạn đang nghĩ gì?",
                        hintStyle: TextStyle(
                          color: AppColors.grayText,
                          fontSize: 20,
                        ),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  menuItem(title: "Ảnh/video", icon: AppImages.icImage),
                  menuItem(title: "Gắn thẻ người khác", icon: AppImages.icTagFriend, color: AppColors.main),
                  menuItem(title: "Cảm xúc/Hoạt động", icon: AppImages.icEmotion),
                  menuItem(title: "Check in",icon: AppImages.icCheckIn),
                  menuItem(title: "Video trực tiếp", icon: AppImages.icLiveStream),
                  menuItem(title: "Màu nền",icon: AppImages.icFont),
                  menuItem(title: "Camera", icon: AppImages.icCamera,color: AppColors.main),
                  menuItem(title: "File GIF", icon: AppImages.icGIF, color:const Color(0xFF4BB7A8)),
                  menuItem(title: "Nhạc",icon: AppImages.icMusic, color: Colors.deepOrange),
                ],
              ),
            )));
  }

  Widget menuItem({String? icon, String? title, Color? color}) {
    return InkWell(
        onTap: () {
          print("tap");
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderColor))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon ?? AppImages.icImage,
                    width: 30,
                    color: color,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   Text(
                    "$title",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
