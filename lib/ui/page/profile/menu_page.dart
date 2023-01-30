import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.menuBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: (Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.menuBackground,
                elevation: 0,
                title: const Text(
                  "Menu",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                actions: [
                  AppRoundIconButton(
                    iconData: Icons.settings,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppRoundIconButton(
                    iconData: Icons.search,
                  )
                ],
              ),
              Row(children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.hardEdge,
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: AppColors.grayBackground,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      AppImages.icDefaultUser,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    String? userId = await SharedPreferencesHelper.getUserId();
                    Application.router?.navigateTo(context, Routes.profile,
                        routeSettings: RouteSettings(arguments: userId));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lê Hồng Ưng",
                        style: AppTextStyle.blackS18Bold,
                      ),
                      Text(
                        "Xem trang cá nhân của bạn",
                        style: AppTextStyle.greyS14,
                      )
                    ],
                  ),
                )
              ]),
              const Divider(
                color: AppColors.grayBorder,
              ),
              GridView.count(
                primary: false,
                shrinkWrap: true,
                childAspectRatio: (1 / .45),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  _menuButton(),
                  _menuButton(
                      title: "Danh sách block",
                      action: () {
                        Application.router
                            ?.navigateTo(context, Routes.listBlockFriends);
                      }),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                  _menuButton(),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.roundIconButtonBackground),
                          onPressed: () {
                            SharedPreferencesHelper.removeTokenAndUserId();
                            Application.router?.navigateTo(
                              context,
                              Routes.root,
                            );
                          },
                          child: const Text(
                            "Đăng xuất",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ))),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _menuButton({String? title, VoidCallback? action}) {
    return GestureDetector(
      onTap: action,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: MediaQuery.of(context).size.width / 2 - 25,
          decoration: BoxDecoration(
              color: AppColors.greyF8F8F8,
              borderRadius: BorderRadius.circular(10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              AppImages.icEmotion,
              width: 24,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title ?? "Bạn bè",
              style:
                  AppTextStyle.blackS14.copyWith(fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
