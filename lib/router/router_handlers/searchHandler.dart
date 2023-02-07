import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/repositories/search_repository.dart';
import 'package:facebook/ui/page/find/find_page.dart';
import 'package:facebook/ui/page/find/find_page_cubit.dart';
import 'package:facebook/ui/page/find/find_result_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler searchHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<SearchRepository>(context);
      return FindPageCubit(repository: repository);
    },
    child: const FindPage(),
  );
});
Handler searchResultHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? keyword = context!.settings!.arguments as String;
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<SearchRepository>(context);
      return FindPageCubit(repository: repository);
    },
    child: FindResultPage(
      keyword: keyword,
    ),
  );
});
