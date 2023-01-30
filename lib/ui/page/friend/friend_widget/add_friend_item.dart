import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendItem extends StatefulWidget {
  final String? userId;
  final String? friendName;
  final String? numMutualFriend;
  final String? avtUrl;
  late String? acceptText;
  final String? cancelText;
  final VoidCallback? accept;
  final VoidCallback? cancel;
  final VoidCallback? block;

  AddFriendItem(
      {Key? key,
      this.userId,
      this.friendName,
      this.numMutualFriend,
      this.acceptText = "Chấp nhận",
      this.cancelText = "Xóa",
      this.accept,
      this.cancel,
      this.block,
      this.avtUrl})
      : super(key: key);

  @override
  State<AddFriendItem> createState() => _AddFriendItemState();
}

class _AddFriendItemState extends State<AddFriendItem> {
  AddFriendItemCubit? _cubit;
  @override
  void initState() {
    _cubit = BlocProvider.of<AddFriendItemCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double avtWidth = 65;
    final widthScreen = MediaQuery.of(context).size.width;
    return BlocBuilder<AddFriendItemCubit, AddFriendItemState>(
        bloc: _cubit,
        buildWhen: (previous, current) =>
            previous.isAcceptLoading != current.isAcceptLoading,
        builder: (context, state) {
          return GestureDetector(
            onLongPress: widget.block,
            child: Row(
              children: [
                widget.avtUrl == null
                    ? Container(
                        alignment: Alignment.bottomCenter,
                        width: avtWidth,
                        height: avtWidth,
                        decoration: const BoxDecoration(
                            color: AppColors.grayBackground,
                            shape: BoxShape.circle),
                        child: Image.asset(
                          AppImages.icDefaultUser,
                          color: Colors.white,
                          width: avtWidth - 5,
                        ))
                    : CachedNetworkImage(
                        imageUrl: widget.avtUrl.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                              width: avtWidth,
                              height: avtWidth,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        placeholder: (context, _) => Container(
                            alignment: Alignment.bottomCenter,
                            width: avtWidth,
                            height: avtWidth,
                            decoration: const BoxDecoration(
                                color: AppColors.grayBackground,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              AppImages.icDefaultUser,
                              color: Colors.white,
                              width: avtWidth - 5,
                            ))),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.friendName ?? "Người dùng facebook",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.numMutualFriend ?? 0} bạn chung",
                              style: const TextStyle(
                                  color: AppColors.grayText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widthScreen / 2 - 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.acceptText == "Thêm bạn bè") {
                                        setState(() {
                                          _cubit!
                                              .setRequestFriend(widget.userId);
                                          widget.acceptText = "Hủy";
                                        });
                                      } else if (widget.acceptText == "Hủy") {
                                        setState(() {
                                          _cubit!
                                              .setRequestFriend(widget.userId);
                                          widget.acceptText = "Thêm bạn bè";
                                        });
                                      } else {
                                        setState(() {
                                          _cubit!.setAcceptFriend(
                                              widget.userId, "1");
                                          widget.accept!();
                                        });
                                      }
                                    },
                                    child: state.isAcceptLoading ==
                                            LoadStatus.LOADING
                                        ? const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            widget.acceptText ?? "Chấp nhận",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1,
                                        backgroundColor: AppColors.main),
                                  ),
                                ),
                                SizedBox(
                                  width: widthScreen / 2 - 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print("Hủy");
                                    },
                                    child: state.isCancelLoading == true
                                        ? const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: AppColors.main,
                                            ),
                                          )
                                        : Text(
                                            widget.cancelText ?? "Xóa",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1,
                                        backgroundColor:
                                            AppColors.commentBackgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
