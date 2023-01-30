import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/ui/page/friend/home_friend/home_friends_cubit.dart';
import 'package:facebook/ui/page/friend/list_block/list_block_cubit.dart';
import 'package:facebook/ui/page/friend/list_block/list_block_page.dart';
import 'package:facebook/ui/page/main_tab.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler suggestFriendHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<FriendRepository>(context);
      return HomeFriendsCubit(repository: repository);
    },
    child: const TabBarPage(),
  );
});

Handler listBlockFriendsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<FriendRepository>(context);
      return ListBlockCubit(repository: repository);
    },
    child: const ListBlockPage(),
  );
});
