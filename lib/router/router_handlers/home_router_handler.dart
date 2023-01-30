import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/ui/page/home/home_page_cubit.dart';
import 'package:facebook/ui/page/main_tab.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler homeTabHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<PostRepository>(context);
      return HomePageCubit(repository: repository);
    },
    child: const TabBarPage(),
  );
});
