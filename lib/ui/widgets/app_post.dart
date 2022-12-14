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
                                  "L?? H???ng ??ng",
                                  style: AppTextStyle.blackS16Bold,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "21m ??? ",
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
                          "CH???NG C?? C?? H???I S???A SAI \nS??? vi???c x???y ra t???i v??ng ?????t H???i Ph??ng chi???u ng??y h??m qua 8/11. Theo camera an ninh ghi l???i, 1 thanh ni??n ?????u tr???n ph??ng nh?? bay tr??n ???????ng. V???a ??i nam thanh ni??n v???a bi???u di???n c??c ?????ng t??c l???ng l??ch, ????nh v??ng, th???m ch?? c??n phi lu??n sang l??n ng?????c l???i v???a ?????u chi???c xe t???i ??ang ??i ?????n.??? ",
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
                              "Xem th??m",
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
                          Text("523 comments ??? "),
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
