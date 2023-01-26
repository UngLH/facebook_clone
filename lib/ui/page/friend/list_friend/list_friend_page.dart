import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListFriendPage extends StatefulWidget {
  const ListFriendPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListFriendPageState();
  }
}

class _ListFriendPageState extends State<ListFriendPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: AppColors.borderColor, width: 1)),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            title: const Text(
              "Bạn bè",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      fillColor: AppColors.commentBackgroundColor,
                      hintText: "Tìm kiếm bạn bè",
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: AppColors.grayIconButton,
                      ),
                      contentPadding:
                          const EdgeInsets.only(bottom: 45 / 2, left: 15),
                      hintStyle: const TextStyle(
                          color: AppColors.grayText, fontSize: 16)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "0 bạn bè",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return _friendItem();
                  },
                  separatorBuilder: (context, state) {
                    return Container(
                      height: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _friendItem() {
    const double avtWidth = 50;
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  width: avtWidth,
                  height: avtWidth,
                  decoration: const BoxDecoration(
                      color: AppColors.grayBackground, shape: BoxShape.circle),
                  child: Image.asset(
                    AppImages.icDefaultUser,
                    color: Colors.white,
                    width: avtWidth - 5,
                  )),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Người dùng facebook",
                    style: AppTextStyle.blackS18
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "100 bạn chung",
                    style: AppTextStyle.blackS14,
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz_outlined,
            color: AppColors.grayIconButton,
          ),
        )
      ],
    );
  }
}
