// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String? friendName;
  final String? numMutualFriend;
  final String? avtUrl;
  final String? created;
  final VoidCallback? removeFriend;
  final VoidCallback? blockFriend;
  final VoidCallback? sendMessage;
  const FriendItem({
    Key? key,
    this.friendName,
    this.numMutualFriend,
    this.avtUrl,
    this.created,
    this.removeFriend,
    this.blockFriend,
    this.sendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double avtWidth = 70;
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  width: avtWidth,
                  height: avtWidth,
                  decoration: const BoxDecoration(
                      color: AppColors.grayBackground, shape: BoxShape.circle),
                  child: Image.asset(
                    AppImages.icDefaultUser,
                    color: Colors.white,
                    width: avtWidth - 5,
                  )),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friendName.toString(),
                    style: AppTextStyle.blackS18
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    numMutualFriend.toString() + " bạn chung",
                    style: AppTextStyle.blackS14,
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz_outlined,
            color: AppColors.grayIconButton,
          ),
        )
      ],
    );
  }
}
