import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppPost extends StatefulWidget {
  const AppPost({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AppPostState();
  }
}

class _AppPostState extends State<AppPost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 220,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lê Hồng Ưng",
                                  style: AppTextStyle.blackS16Bold,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "21m • ",
                                      style: TextStyle(
                                        color: AppColors.grayText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                      Icons.public,
                                      size: 14,
                                      color: AppColors.grayIconButton,
                                    ),
                                  ],
                                )
                              ])
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                              color: AppColors.grayIconButton,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.grayIconButton,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                            child: Text(
                          "CHẲNG CÓ CƠ HỘI SỬA SAI \nSự việc xảy ra tại vùng đất Hải Phòng chiều ngày hôm qua 8/11. Theo camera an ninh ghi lại, 1 thanh niên đầu trần phóng như bay trên đường. Vừa đi nam thanh niên vừa biểu diễn các động tác lạng lách, đánh võng, thậm chí còn phi luôn sang làn ngược lại vỉa đầu chiếc xe tải đang đi đến.… ",
                          style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black),
                        )),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              print("Extend");
                            },
                            child: const Text(
                              "Xem thêm",
                              style: TextStyle(color: AppColors.grayText),
                            ),
                          ),
                        )
                      ]),
                    )),
                Image.asset(
                  AppImages.testImagePost,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                  height: MediaQuery.of(context).size.height - 435,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.icLikeColor,
                            width: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("7.3K")
                        ],
                      ),
                      Row(
                        children: const [
                          Text("523 comments • "),
                          Text("29 share")
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: AppColors.grayBorder,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.icLike,
                            width: 22,
                            color: AppColors.grayIconButton,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Like")
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.icComment,
                            width: 22,
                            color: AppColors.grayIconButton,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Comment")
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.icShare,
                            width: 22,
                            color: AppColors.grayIconButton,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Share")
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
