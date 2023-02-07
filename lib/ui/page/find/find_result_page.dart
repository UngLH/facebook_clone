import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/models/entities/post/post_search_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/find/find_page_cubit.dart';
import 'package:facebook/ui/widgets/app_post_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindResultPage extends StatefulWidget {
  String? keyword;
  FindResultPage({Key? key, this.keyword}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FindResultPageState();
  }
}

class _FindResultPageState extends State<FindResultPage> {
  FindPageCubit? _cubit;
  TextEditingController? commentController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? userId;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _cubit = BlocProvider.of<FindPageCubit>(context);
    _cubit!.search(widget.keyword);
    commentController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.grayBackground,
      appBar: AppBar(
          shape: const Border(
              bottom: BorderSide(
                  color: AppColors.commentBackgroundColor, width: 1)),
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
          title: Text(
            "Danh sách bài viết",
            style: TextStyle(color: Colors.black),
          )),
      body: BlocBuilder<FindPageCubit, FindPageState>(
          bloc: _cubit,
          buildWhen: (previous, current) =>
              previous.loadingPostStatus != current.loadingPostStatus,
          builder: (context, state) {
            if (state.loadingPostStatus == LoadStatus.LOADING) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.main,
                ),
              );
            } else if (state.loadingPostStatus == LoadStatus.FAILURE) {
              return const Center(child: Text("Đã có lỗi xảy ra!"));
            } else if (state.loadingPostStatus == LoadStatus.EMPTY) {
              return const Center(child: Text("Không tìm thấy bài viết nào!"));
            } else if (state.loadingPostStatus == LoadStatus.SUCCESS) {
              return state.posts!.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.posts!.length,
                            itemBuilder: (context, index) {
                              PostSearchEntity post = state.posts![index];
                              return AppPostSearch(
                                  post: post, pressLike: () {});
                            },
                            separatorBuilder: (context, state) {
                              return Container(
                                height: 10,
                                decoration: const BoxDecoration(
                                    color: AppColors.grayBackground),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : const Center(child: Text("Không tìm thấy bài viết nào!"));
            } else {
              return const Center(child: Text("Không tìm thấy bài viết nào!"));
            }
          }),
    );
  }
}
