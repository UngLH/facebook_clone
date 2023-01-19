import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends State<FindPage> {
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
          title: Container(
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
                  fillColor: AppColors.roundIconButtonBackground,
                  hintText: "Tìm kiếm",
                  contentPadding:
                      const EdgeInsets.only(bottom: 45 / 2, left: 15),
                  hintStyle:
                      const TextStyle(color: AppColors.grayText, fontSize: 16)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tìm kiếm gần đây",
                    style: AppTextStyle.blackS20Bold,
                  ),
                  const Text(
                    "Xem tất cả",
                    style: TextStyle(
                        color: AppColors.darkMain,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              searchItem(),
              searchItem()
            ],
          ),
        ));
  }

  Widget searchItem() {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 30,
          color: AppColors.grayBackground,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            "Quân khu 7",
            style: TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: AppColors.grayIconButton,
            ))
      ],
    );
  }
}
