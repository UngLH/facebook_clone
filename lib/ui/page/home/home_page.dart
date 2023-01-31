import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/home/home_page_cubit.dart';
import 'package:facebook/ui/widgets/app_post.dart';
import 'package:facebook/ui/widgets/app_post_modal.dart';
import 'package:facebook/ui/widgets/empty_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomePageCubit? _cubit;
  TextEditingController? commentController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription _loadingSubscription;
  String? userId;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _cubit = BlocProvider.of<HomePageCubit>(context);
    _cubit!.getListPost();
    commentController = TextEditingController(text: '');

    _loadingSubscription = _cubit!.loadingController.stream.listen((event) {
      if (event == LoadStatus.TOKEN_INVALID) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Thông báo'),
                content: Text('Phiên bản đã hết hạn'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Application.router?.navigateTo(
                        _scaffoldKey.currentState!.context,
                        Routes.login,
                        clearStack: true,
                      );
                    },
                    child: Text('Đăng xuất'),
                  )
                ],
              );
            });
      }
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefreshData() async {
    _cubit!.getListPost();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.grayBackground,
      body: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: _cubit,
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            if (state.loadingStatus == LoadStatus.LOADING) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.main,
                ),
              );
            } else if (state.loadingStatus == LoadStatus.FAILURE) {
              return const Center(child: Text("Đã có lỗi xảy ra!"));
            } else if (state.loadingStatus == LoadStatus.EMPTY) {
              return AppEmptyListPostPage();
            } else {
              return Column(
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
                                Application.router
                                    ?.navigateTo(context, Routes.addPost);
                              },
                              child: Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: AppColors.grayBackground)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.main,
                      onRefresh: _onRefreshData,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.listPost!.length,
                        itemBuilder: (context, index) {
                          return AppPost(
                            post: state.listPost![index],
                            commentController: commentController,
                            openProfile: () {
                              Application.router?.navigateTo(
                                  context, Routes.profile,
                                  routeSettings: RouteSettings(
                                      arguments: state
                                          .listPost![index].authorEntity!.id));
                            },
                            pressLike: () {
                              _cubit!.likePost(state.listPost![index].id);
                            },
                            pressMoreAction: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor:
                                      AppColors.commentBackgroundColor,
                                  builder: (context) {
                                    return ModalPostWidget(
                                      deletePost: () {
                                        Navigator.pop(context);
                                        _cubit!
                                            .delPost(state.listPost![index].id);
                                        // _onRefreshData();
                                      },
                                      editPost: () {
                                        Application.router?.navigateTo(
                                            context, Routes.editPost,
                                            routeSettings: RouteSettings(
                                                arguments:
                                                    state.listPost![index]));
                                      },
                                    );
                                  });
                            },
                          );
                        },
                        separatorBuilder: (context, state) {
                          return Container(
                            height: 10,
                            decoration: const BoxDecoration(
                                color: AppColors.grayBackground),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
