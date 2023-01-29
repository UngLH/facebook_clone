import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_friend_item_state.dart';

class AddFriendItem extends StatefulWidget {
  final String? friendName;
  final String? numMutualFriend;
  final String? avtUrl;
  final String? acceptText;
  final String? cancelText;
  final VoidCallback? accept;
  final VoidCallback? cancel;

  const AddFriendItem(
      {Key? key,
      this.friendName,
      this.numMutualFriend,
      this.acceptText,
      this.cancelText,
      this.avtUrl,
      this.accept,
      this.cancel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddFriendItemState();
}

class _AddFriendItemState extends State<AddFriendItem> {
  AddFriendItemCubit? _cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    AddFriendItemState addFriendItemState = AddFriendItemState(mode: "");
    _cubit = AddFriendItemCubit(addFriendItemState);
  }

  @override
  Widget build(BuildContext context) {
    double avtWidth = 80;
    
    return BlocBuilder<AddFriendItemCubit, AddFriendItemState> (
      bloc: _cubit,
      builder: (context, state) {
        if(state.mode == ""){
          return Row(
            children: [
              widget.avtUrl == null
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      width: avtWidth,
                      height: avtWidth,
                      decoration: const BoxDecoration(
                          color: AppColors.grayBackground, shape: BoxShape.circle),
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
                                width: 140,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(widget.acceptText == "Chấp nhận"){
                                      _cubit?.accept();
                                    } else {
                                      _cubit?.addFriend();
                                    }
                                    widget.accept!();
                                  },
                                  child: Text(
                                    widget.acceptText ?? "Chấp nhận",
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      elevation: 1, backgroundColor: AppColors.main),
                                ),
                              ),
                              SizedBox(
                                width: 140,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(widget.acceptText == "Chấp nhận"){
                                      _cubit?.reject();
                                    } else {
                                      _cubit?.remove();
                                    }
                                    widget.cancel!();
                                  },
                                  child: Text(
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
              const SizedBox(
                width: 20,
              ),
            ],
            
          );
        } else if(state.mode == "accept") {
          return Row(
            children: [
              widget.avtUrl == null
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      width: avtWidth,
                      height: avtWidth,
                      decoration: const BoxDecoration(
                          color: AppColors.grayBackground, shape: BoxShape.circle),
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
                          Text("Các bạn đã trở thành bạn bè",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black.withOpacity(0.6))),
                          const SizedBox(
                              width: 20,
                          ),
                        ],
                        
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if(state.mode == "reject") {
          return Row(
            children: [
              widget.avtUrl == null
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      width: avtWidth,
                      height: avtWidth,
                      decoration: const BoxDecoration(
                          color: AppColors.grayBackground, shape: BoxShape.circle),
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
                          Text("Yêu cầu đã bị gỡ",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black.withOpacity(0.6))),
                          const SizedBox(
                              width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if(state.mode == "add_friend"){
          return Row(
            children: [
              widget.avtUrl == null
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      width: avtWidth,
                      height: avtWidth,
                      decoration: const BoxDecoration(
                          color: AppColors.grayBackground, shape: BoxShape.circle),
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
                          Text("Yêu cầu đã được gửi",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black.withOpacity(0.6))),
                          const SizedBox(
                              width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox(height: 0,);
        }
      },
    );
  }
}
