import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/block_friend_modal.dart';
import 'package:facebook/ui/page/friend/friend_widget/friend_item.dart';
import 'package:facebook/ui/page/friend/list_block/list_block_cubit.dart';
import 'package:facebook/ui/page/friend/list_friend/list_friend_cubit.dart';
import 'package:facebook/ui/widgets/comment/app_empty_comment.dart';
import 'package:facebook/ui/widgets/empty_post_page.dart';
import 'package:facebook/ui/widgets/friend/app_empty_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBlockPage extends StatefulWidget {
  const ListBlockPage({Key? key, String? userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListBlockPageState();
  }
}

class _ListBlockPageState extends State<ListBlockPage> {
  ListBlockCubit? _cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _cubit = BlocProvider.of<ListBlockCubit>(context);
    _cubit!.getListBlocks();
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Danh sách block",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            )),
        body: BlocBuilder<ListBlockCubit, ListBlockState>(
            builder: (context, state) {
          if (state.loadingStatus == LoadStatus.LOADING) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.main,
              ),
            );
          } else if (state.loadingStatus == LoadStatus.FAILURE) {
            return const AppEmptyFriend();
          } else if (state.loadingStatus == LoadStatus.EMPTY) {
            return const AppEmptyFriend();
          } else if (state.loadingStatus == LoadStatus.SUCCESS) {
            return state.listBlocks!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                                contentPadding: const EdgeInsets.only(
                                    bottom: 45 / 2, left: 15),
                                hintStyle: const TextStyle(
                                    color: AppColors.grayText, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${state.listBlocks!.length.toString()} người bị block",
                          style: const TextStyle(
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
                            itemCount: state.listBlocks!.length,
                            itemBuilder: (context, index) {
                              return FriendItem(
                                friendName: state.listBlocks![index].username ??
                                    "Người dùng facebook",
                                avtUrl: state.listBlocks![index].avatar,
                                blockFriend: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor:
                                          AppColors.commentBackgroundColor,
                                      builder: (context) {
                                        return BlockFriendModal(
                                          block: () async {
                                            _cubit!.setBlock(state
                                                .listBlocks![index].userId
                                                .toString());
                                            Navigator.of(context).pop();
                                          },
                                          text: "Bỏ chặn",
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
                        ),
                      ],
                    ),
                  )
                : const AppEmptyFriend();
          } else {
            return const AppEmptyFriend();
          }
        }));
  }
}
