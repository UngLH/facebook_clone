import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/page/conversations/chat_detail/chat_detail.dart';
import 'package:facebook/ui/page/conversations/chats/list_friend_cubit.dart';
import 'package:facebook/ui/page/conversations/home/home.dart';
import 'package:facebook/ui/page/conversations/profile/profile.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';

Handler conversationHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return BlocProvider(
      create: (context) {
        final repository = RepositoryProvider.of<AuthRepository>(context);
        return ListFriendCubit(authRepository: repository);
      },
      child: const HomeScreen(),
    );
  },
);

Handler conversationDetailHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      ChatDetail(friendItem: ListFriendModel()),
);

Handler conversationProfileHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const Profile(),
);
