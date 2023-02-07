import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/repositories/user_repository.dart';
import 'package:facebook/ui/page/profile/profile.dart';
import 'package:facebook/ui/page/profile/profile_cubit.dart';
import 'package:facebook/ui/page/profile/profile_edit_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root
Handler profileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String userId = context!.settings!.arguments as String;
  return BlocProvider(
    create: (context) {
      final friendRepository = RepositoryProvider.of<FriendRepository>(context);
      final userRepository = RepositoryProvider.of<UserRepository>(context);
      return ProfileCubit(
          friendRepository: friendRepository, userRepository: userRepository);
    },
    child: ProfilePage(
      userId: userId,
    ),
  );
});

Handler profileEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  EditPageArgument args = context!.settings!.arguments as EditPageArgument;
  return BlocProvider(
    create: (context) {
      final friendRepository = RepositoryProvider.of<FriendRepository>(context);
      final userRepository = RepositoryProvider.of<UserRepository>(context);
      return ProfileCubit(
          friendRepository: friendRepository, userRepository: userRepository);
    },
    child: ProfileEditPage(
      args: args,
    ),
  );
});
