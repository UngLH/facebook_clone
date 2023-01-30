import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item.dart';
import 'package:facebook/ui/widgets/empty_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'friend_suggest_cubit.dart';

class FriendSuggestPage extends StatefulWidget {
  const FriendSuggestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendSuggestPage();
  }
}

class _FriendSuggestPage extends State<FriendSuggestPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController? _controller;
  FriendSuggestCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _cubit = BlocProvider.of<FriendSuggestCubit>(context);
    _cubit!.getListSuggestFriends();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _scrollListener() {
    if (_controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange) {
      _cubit!.getMoreSuggestFriends();
    }
    if (_controller!.offset <= _controller!.position.minScrollExtent &&
        !_controller!.position.outOfRange) {
      _cubit!.getListSuggestFriends();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Những người bạn có thể biết",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        body: BlocBuilder<FriendSuggestCubit, FriendSuggestState>(
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
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 0),
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Những người bạn có thể biết",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.listSuggestFriends!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        FriendSuggestEntity friend =
                            state.listSuggestFriends![index];
                        return AddFriendItem(
                          friendName: friend.username,
                          numMutualFriend: friend.sameFriend,
                          avtUrl: friend.avatar,
                          acceptText: "Thêm bạn bè",
                          cancelText: "Gỡ",
                          // accept: (() async {
                          //   String? token = await SharedPreferencesHelper.getToken();
                          //   _cubit!.repository!.setRequestFriend(token, friend.userId);
                          // }),
                        );
                      },
                      separatorBuilder: (context, state) {
                        return Container(
                          height: 0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
