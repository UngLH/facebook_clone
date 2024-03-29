import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/conversation_item.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/search_bar.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/stories_list.dart';
import 'package:facebook/ui/widgets/messenger_app_bar/messenger_app_bar.dart';

import 'list_friend_cubit.dart';

class ListFriend extends StatefulWidget {
  const ListFriend({Key? key}) : super(key: key);

  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
  ListFriendCubit? _cubit;
  late ScrollController _controller;
  bool _isScroll = false;

  _scrollListener() {
    if (_controller.offset > 0) {
      setState(() {
        _isScroll = true;
      });
    } else {
      setState(() {
        _isScroll = false;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _cubit = BlocProvider.of<ListFriendCubit>(context);
    _cubit!.getListConversation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            _buildMessengerAppBar(_isScroll),
            _buildRootListView(),
          ],
        ),
      ),
    );
  }

  _buildMessengerAppBar(_isScroll) {
    return (MessengerAppBar(
      isScroll: _isScroll,
      title: 'Chats',
      actions: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: const Icon(
            Icons.photo_camera,
            size: 25.0,
          ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: const Icon(
            Icons.edit,
            size: 25.0,
          ),
        ),
      ],
      isBack: false,
    ));
  }

  _buildRootListView() {
    return BlocBuilder<ListFriendCubit, ListFriendState>(
      builder: (context, state) => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10.0),
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildSearchBar();
            } else if (index == 1) {
              return _buildStoriesList(_cubit?.searchConversations());
            } else {
              return ConversationItem(
                friendItem: (_cubit?.searchConversations())![index - 2],
                dateFormat: '',
                cubit_: _cubit,
              );
            }
          },
          itemCount: (_cubit?.searchConversations()?.length)! + 2,
        ),
      )
    );
  }

  _buildSearchBar() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: SearchBar(),
    );
  }

  _buildStoriesList(List<ListFriendModel>? data) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 16.0),
      child: StoriesList(friendList: data ?? friendList),
    );
  }
}
