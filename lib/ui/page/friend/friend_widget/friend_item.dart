// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatefulWidget {
  final String? friendName;
  final String? numMutualFriend;
  final String? avtUrl;
  final String? created;
  final VoidCallback? removeFriend;
  final VoidCallback? blockFriend;
  final VoidCallback? sendMessage;
  final VoidCallback? onTap;

  const FriendItem(
      {Key? key,
      this.friendName,
      this.numMutualFriend,
      this.avtUrl,
      this.created,
      this.removeFriend,
      this.blockFriend,
      this.sendMessage,
      this.onTap})
      : super(key: key);

  @override
  State<FriendItem> createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
  @override
  Widget build(BuildContext context) {
    double avtWidth = 70;
    return Row(
      children: [
        Expanded(
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
                          )),
                    ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                  onTap: widget.onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friendName.toString(),
                        style: AppTextStyle.blackS18
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      widget.numMutualFriend != null
                          ? Text(
                              widget.numMutualFriend.toString() + " bạn chung",
                              style: AppTextStyle.blackS14,
                            )
                          : Container(),
                    ],
                  ))
            ],
          ),
        ),
        IconButton(
          onPressed: widget.blockFriend,
          icon: const Icon(
            Icons.more_horiz_outlined,
            color: AppColors.grayIconButton,
          ),
        )
      ],
    );
  }
}
