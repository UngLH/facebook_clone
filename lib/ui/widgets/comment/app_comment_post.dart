import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/models/entities/comment/comment_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/widgets/comment/app_comment_cubit.dart';
import 'package:facebook/ui/widgets/comment/app_empty_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCommentPostWidget extends StatefulWidget {
  String postId;

  AppCommentPostWidget({Key? key, required this.postId}) : super(key: key);

  @override
  State<AppCommentPostWidget> createState() => _AppCommentPostWidgetState();
}

class _AppCommentPostWidgetState extends State<AppCommentPostWidget> {
  late double heightResize = 1;
  AppCommentCubit? _cubit;
  TextEditingController? commentController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _cubit = BlocProvider.of<AppCommentCubit>(context);
    _cubit!.getListComments(widget.postId, 0, 20);
    commentController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefreshData() async {
    _cubit!.getListComments(widget.postId, 0, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 105,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.lineGray))),
          child: Column(
            children: [
              Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  cursorWidth: 1,
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: commentController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      filled: true,
                      fillColor: AppColors.commentBackgroundColor,
                      hintText: "Viết bình luận",
                      contentPadding:
                          const EdgeInsets.only(bottom: 45 / 2, left: 15),
                      hintStyle: const TextStyle(
                          color: AppColors.grayText, fontSize: 16)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _cubit!
                            .setComment(widget.postId, commentController!.text);
                        commentController!.clear();
                      });
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: commentController!.text == ''
                          ? AppColors.grayIconButton
                          : AppColors.blueIconButton,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: SafeArea(
            child: BlocBuilder<AppCommentCubit, AppCommentState>(
                bloc: _cubit,
                buildWhen: (previous, current) =>
                    previous.loadingStatus != current.loadingStatus,
                builder: (context, state) {
                  if (state.loadingStatus == LoadStatus.LOADING) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.loadingStatus == LoadStatus.FAILURE) {
                    return const Center(
                      child: Text(
                        "Đã có lỗi xảy ra!",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (state.loadingStatus == LoadStatus.EMPTY) {
                    return const AppEmptyComment();
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.icLikeColor,
                                        width: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "4.200",
                                        style: AppTextStyle.blackS16.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Icon(
                                        Icons.navigate_next_outlined,
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    AppImages.icLike,
                                    width: 20,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tất cả bình luận",
                                    style: AppTextStyle.blackS16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.expand_more_outlined,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: RefreshIndicator(
                                  color: AppColors.main,
                                  onRefresh: _onRefreshData,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state.listComments!.length,
                                    itemBuilder: (context, index) {
                                      return _commentItem(
                                          state.listComments![index]);
                                    },
                                    separatorBuilder: (context, state) {
                                      return Container(
                                        height: 10,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  }
                })));
  }

  Widget _commentItem(CommentEntity commentEntity) {
    String created = commentEntity.created ?? "";
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
    final widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: AppColors.grayBackground, shape: BoxShape.circle),
              child: Image.asset(
                AppImages.icDefaultUser,
                color: Colors.white,
                width: 45,
              )),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: widthScreen - 65,
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.commentBackgroundColor),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentEntity.authorEntity!.username ??
                              "Người dùng facebook",
                          style: AppTextStyle.blackS16Bold,
                        ),
                        Text(commentEntity.comment ?? "")
                      ],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    createdString,
                    style: AppTextStyle.greyS14
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Thích",
                    style: AppTextStyle.greyS14
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Phản hồi",
                    style: AppTextStyle.greyS14
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
