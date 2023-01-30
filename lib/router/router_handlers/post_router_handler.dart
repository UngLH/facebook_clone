import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/ui/page/add_post/add_post_cubit.dart';
import 'package:facebook/ui/page/add_post/add_post_page.dart';
import 'package:facebook/ui/page/edit_post/edit_post_cubit.dart';
import 'package:facebook/ui/page/edit_post/edit_post_page.dart';
import 'package:facebook/ui/widgets/comment/app_comment_cubit.dart';
import 'package:facebook/ui/widgets/comment/app_comment_post.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler addPostHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<PostRepository>(context);
      return AddPostCubit(repository: repository);
    },
    child: const AddPostPage(),
  );
});
Handler editPostHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<PostRepository>(context);
      return EditPostCubit(repository: repository);
    },
    child: const EditPostPage(),
  );
});
// Handler appCommentHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return BlocProvider(
//     create: (context) {
//       final repository = RepositoryProvider.of<PostRepository>(context);
//       return AppCommentCubit(repository: repository);
//     },
//     child: AppCommentPostWidget(),
//   );
// });
