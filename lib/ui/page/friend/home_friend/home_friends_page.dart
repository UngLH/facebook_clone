import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item.dart';
import 'package:facebook/ui/page/friend/friend_widget/block_friend_modal.dart';
import 'package:facebook/ui/page/friend/home_friend/home_friends_cubit.dart';
import 'package:facebook/ui/page/friend/list_friend/list_friend_page.dart';
import 'package:facebook/ui/widgets/empty_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFriendPage extends StatefulWidget {
  const HomeFriendPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeFriendPageState();
  }
}

class _HomeFriendPageState extends State<HomeFriendPage> {
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeFriendsCubit? _cubit;
  late StreamSubscription _loadingSubscription;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _cubit = BlocProvider.of<HomeFriendsCubit>(context);
    _cubit!.getListSuggestFriends();
    _cubit!.getListRequestFriends();
  }

  @override
  void dispose() {
    super.dispose();
    _loadingSubscription.cancel();
  }

  Future<void> _onRefreshData() async {
    _cubit!.getListSuggestFriends();
    _cubit!.getListRequestFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<HomeFriendsCubit, HomeFriendsState>(
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
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
            child: SingleChildScrollView(
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
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 10.0),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(30.0)),
                          child: const Text('Bạn bè',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListFriendPage(
                                      userId: "userid",
                                    )),
                          );
                        },
                      )
                    ],
                  ),
                  if (state.listRequestFriends != null ||
                      state.listRequestFriends!.isNotEmpty) ...[
                    const Divider(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Lời mời kết bạn",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              state.listRequestFriends!.length.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.listRequestFriends!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        FriendRequestEntity friend =
                            state.listRequestFriends![index];
                        String? avatar = friend.avatar;
                        return AddFriendItem(
                          friendName: friend.username,
                          numMutualFriend: friend.sameFriend,
                          avtUrl: avatar,
                          acceptText: "Chấp nhận",
                          cancelText: "Từ chối",
                          userId: friend.userId,
                          accept: () {
                            _cubit!.getListSuggestFriends();
                          },
                          block: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor:
                                    AppColors.commentBackgroundColor,
                                builder: (context) {
                                  return BlockFriendModal(
                                    block: () {
                                      _cubit!
                                          .setBlock(friend.userId.toString());
                                      Navigator.of(context).pop();
                                      _onRefreshData();
                                    },
                                  );
                                });
                          },
                        );
                      },
                      separatorBuilder: (context, state) {
                        return Container(
                          height: 0,
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                    ),
                  ] else
                    const SizedBox(),
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
                        userId: friend.userId,
                        friendName: friend.username,
                        numMutualFriend: friend.sameFriend,
                        avtUrl: friend.avatar,
                        acceptText: "Thêm bạn bè",
                        cancelText: "Gỡ",
                        block: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: AppColors.commentBackgroundColor,
                              builder: (context) {
                                return BlockFriendModal(
                                  block: () {
                                    _cubit!.setBlock(friend.userId.toString());
                                    Navigator.of(context).pop();
                                    _onRefreshData();
                                  },
                                );
                              });
                        },
                      );
                    },
                    separatorBuilder: (context, state) {
                      return Container(
                        height: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
