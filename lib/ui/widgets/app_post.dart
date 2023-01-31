import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/models/entities/media/image_entity.dart';
import 'package:facebook/models/entities/post/post_response_entity.dart';
import 'package:facebook/models/entities/post/post_search_entity.dart';
import 'package:facebook/ui/widgets/comment/app_comment_post.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AppPost extends StatefulWidget {
  PostResponseEntity? post;
  TextEditingController? commentController;
  Function pressLike;
  Function pressMoreAction;
  Function openProfile;

  AppPost(
      {Key? key,
      this.post,
      required this.pressLike,
      this.commentController,
      required this.openProfile,
      required this.pressMoreAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppPostState();
  }
}

class _AppPostState extends State<AppPost> with AutomaticKeepAliveClientMixin {
  var timeNow = DateTime.now();
  String? _thumbnailUrl;
  bool isLikeState = false;

  Future<String> generateThumbnail() async {
    _thumbnailUrl = await VideoThumbnail.thumbnailFile(
        video: widget.post!.video!.url.toString(),
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP);
    // setState(() {});
    return _thumbnailUrl.toString();
  }

  @override
  void initState() {
    super.initState();
    if (widget.post!.video != null) {
      generateThumbnail();
    }
    isLikeState = widget.post!.isLiked == "1" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    String created = widget.post!.created ?? "";
    DateTime timeStampToDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(created) * 1000);
    var createdDateInMinute =
        DateTime.now().difference(timeStampToDate).inMinutes;

    var createdString = '';
    if (createdDateInMinute == 0) {
      createdString = "Vừa xong";
    } else if (createdDateInMinute > 0 && createdDateInMinute < 60) {
      createdString = "$createdDateInMinute phút trước";
    } else if (createdDateInMinute >= 60 && createdDateInMinute < 60 * 24) {
      createdString =
          "${DateTime.now().difference(timeStampToDate).inHours} giờ trước";
    } else {
      createdString =
          "${DateTime.now().difference(timeStampToDate).inDays} ngày trước";
    }
    double avtWidth = 40;

    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.openProfile();
                        },
                        child: Row(
                          children: [
                            widget.post!.authorEntity!.avatar == null
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
                                    imageUrl: widget.post!.authorEntity!.avatar
                                        .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
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
                              width: 10,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post!.authorEntity!.username ??
                                        "Người dùng Facebook",
                                    style: AppTextStyle.blackS16Bold,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        createdString,
                                        style: const TextStyle(
                                          color: AppColors.grayText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.public,
                                        size: 14,
                                        color: AppColors.grayIconButton,
                                      ),
                                    ],
                                  )
                                ])
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          widget.post!.canEdit == "1"
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.pressMoreAction();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: AppColors.grayIconButton,
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                            child: Text(
                          widget.post!.described ?? "",
                          maxLines: 5,
                          style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black),
                        )),
                        widget.post!.described != null
                            ? (widget.post!.described!.length > 300
                                ? WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        print("Extend");
                                      },
                                      child: const Text(
                                        "Xem thêm",
                                        style: TextStyle(
                                            color: AppColors.grayText),
                                      ),
                                    ),
                                  )
                                : WidgetSpan(child: Container()))
                            : WidgetSpan(child: Container())
                      ]),
                    )),
                // widget.post!.video != null
                //     ? videoWidget(video: widget.post!.video)
                //     : Container(),
                mediaShow(widget.post!.images, widget.post?.video),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.post!.like == "0"
                          ? Container()
                          : Row(
                              children: [
                                Image.asset(
                                  AppImages.icLikeColor,
                                  width: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(widget.post!.like.toString())
                              ],
                            ),
                      widget.post!.comment == "0"
                          ? Container()
                          : Row(
                              children: [
                                Text("${widget.post!.comment} bình luận  "),
                              ],
                            ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: AppColors.grayBorder,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLikeState = !isLikeState;
                            widget.pressLike();
                          });
                        },
                        child: Row(
                          children: [
                            isLikeState
                                ? Image.asset(
                                    AppImages.icLiked,
                                    width: 21,
                                    color: AppColors.main,
                                  )
                                : Image.asset(
                                    AppImages.icLike,
                                    width: 22,
                                    color: AppColors.grayIconButton,
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("Like")
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return AppCommentPostWidget(
                                  postId: widget.post!.id.toString(),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.icComment,
                              width: 22,
                              color: AppColors.grayIconButton,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("Comment")
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.icShare,
                            width: 22,
                            color: AppColors.grayIconButton,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Share")
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget mediaShow(List<ImageEntity>? images, VideoEntity? video) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    if (video == null) {
      if (images == null) {
        return Container();
      } else {
        switch (images.length) {
          case 1:
            return CachedNetworkImage(
              imageUrl: widget.post!.images![0].url.toString(),
              imageBuilder: (context, imageProvider) => Container(
                width: widthScreen,
                height: heightScreen - 435,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          case 2:
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.post!.images![0].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: widthScreen,
                    height: heightScreen - 600,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 3,
                ),
                CachedNetworkImage(
                  imageUrl: widget.post!.images![1].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: widthScreen,
                    height: heightScreen - 600,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            );
          case 3:
            return Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.post!.images![0].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: widthScreen / 2,
                    height: heightScreen - 424,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![1].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: heightScreen / 2 - 212,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![2].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: heightScreen / 2 - 212,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                )
              ],
            );
          case 4:
            return Column(
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![0].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![1].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![2].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![3].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                )
              ],
            );
          default:
            {
              return Container();
            }
        }
      }
    } else {
      if (images == null) {
        return videoWidget(
          video: video,
          width: widthScreen,
          height: heightScreen - 424,
        );
      } else {
        switch (images.length) {
          case 1:
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.post!.images![0].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: widthScreen,
                    height: heightScreen - 600,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 3,
                ),
                videoWidget(
                    video: video,
                    width: widthScreen,
                    height: heightScreen - 600),
              ],
            );
          case 2:
            return Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.post!.images![0].url.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: widthScreen / 2,
                    height: heightScreen - 424,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![1].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: heightScreen / 2 - 212,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    videoWidget(
                      video: video,
                      width: widthScreen / 2 - 3,
                      height: heightScreen / 2 - 212,
                    ),
                  ],
                )
              ],
            );
          case 3:
            return Column(
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![0].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![1].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2 - 3,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.post!.images![2].url.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: widthScreen / 2,
                        height: (heightScreen - 600) / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    videoWidget(
                        video: video,
                        width: widthScreen / 2 - 3,
                        height: (heightScreen - 600) / 2),
                  ],
                )
              ],
            );
          default:
            {
              return Container();
            }
        }
      }
    }
  }

  Widget videoWidget({VideoEntity? video, double? width, double? height}) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return FutureBuilder<String>(
      future:
          generateThumbnail(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Image.file(
                  File(_thumbnailUrl!),
                  width: widthScreen,
                  height: heightScreen - 424,
                  fit: BoxFit.fill,
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black45,
                  child: Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
