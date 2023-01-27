import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/friend/list_suggest_friend/suggest_friends_page.dart';
import 'package:facebook/ui/page/home/home_page.dart';
import 'package:facebook/ui/page/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabBarState();
  }
}

class _TabBarState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool _isShowAppbar = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: _isShowAppbar
              ? AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    // Status bar color
                    statusBarColor: Colors.white,

                    // Status bar brightness (optional)
                    statusBarIconBrightness:
                        Brightness.dark, // For Android (dark icons)
                    statusBarBrightness:
                        Brightness.light, // For iOS (dark icons)
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    "facebook",
                    style: TextStyle(
                        color: AppColors.main,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    _headerButton(Icons.add),
                    const SizedBox(
                      width: 10,
                    ),
                    _headerButton(Icons.search),
                    const SizedBox(
                      width: 10,
                    ),
                    _headerImageButton(AppImages.icMessenger),
                  ],
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.grayBackground))),
                  child: Material(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: AppColors.blueIconButton,
                      indicatorWeight: 3,
                      onTap: onTabTapped,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.home,
                            color: _tabController.index == 0
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.people,
                            color: _tabController.index == 1
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.ondemand_video,
                            color: _tabController.index == 2
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.storefront,
                            color: _tabController.index == 3
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.notifications,
                            color: _tabController.index == 4
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.menu,
                            color: _tabController.index == 5
                                ? AppColors.blueIconButton
                                : AppColors.grayIconButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  HomePage(),
                  SuggestFriendPage(),
                  // FriendRequest(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  MenuPage()
                ]))
              ],
            ),
          ),
        ));
  }

  Widget _headerButton(IconData? iconData) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {},
      child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF1F2F6),
          ),
          child: Center(
            child: Icon(
              iconData,
              color: Colors.black,
            ),
          )),
    );
  }

  Widget _headerImageButton(String? image) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        Application.router?.navigateTo(
          context,
          Routes.conversation,
        );
      },
      child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF1F2F6),
          ),
          child: Center(
            child: Image.asset(
              image!,
              width: 18,
            ),
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if (_tabController.index == 0) {
        _isShowAppbar = true;
      } else {
        _isShowAppbar = false;
      }
    });
  }
}
