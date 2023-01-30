import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:flutter/material.dart';

class AddFriendItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double avtWidth = 80;
    return Row(
      children: [
        avtUrl == null
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
                imageUrl: avtUrl.toString(),
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
                      friendName ?? "Người dùng facebook",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${numMutualFriend ?? 0} bạn chung",
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
                            onPressed: () {},
                            child: Text(
                              acceptText ?? "Chấp nhận",
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
                            onPressed: () {},
                            child: Text(
                              cancelText ?? "Xóa",
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
    );
  }
}
