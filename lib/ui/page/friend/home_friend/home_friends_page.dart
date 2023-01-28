import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item.dart';
import 'package:facebook/ui/page/friend/home_friend/suggest_friends_cubit.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeFriendsCubit? _cubit;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 0),
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
                      children: const [
                        Text(
                          "Lời mời kết bạn",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
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
                        FriendRequestEntity friend = state.listRequestFriends![index];
                        String? avatar = friend.avatar;
                        return AddFriendItem(
                          friendName: friend.username,
                          numMutualFriend: friend.sameFriend,
                          avtUrl: avatar,
                          acceptText: "Chấp nhận",
                          cancelText: "Từ chối",
                        );
                      },
                      separatorBuilder: (context, state) {
                        return Container(
                          height: 10,
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.borderColor,
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
                        FriendEntity friend = state.listSuggestFriends![index];
                        return AddFriendItem(
                          friendName: friend.username,
                          numMutualFriend: friend.sameFriend,
                          avtUrl: friend.avatar,
                          acceptText: "Thêm bạn bè",
                          cancelText: "Gỡ",
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
        }));
  }
}
