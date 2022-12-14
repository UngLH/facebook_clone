import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/conversation_item.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/search_bar.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/stories_list.dart';
import 'package:facebook/ui/widgets/messenger_app_bar/messenger_app_bar.dart';

class ListFriend extends StatefulWidget {
  const ListFriend({ Key? key}) : super(key: key);

  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
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
            FontAwesomeIcons.camera,
            size: 18.0,
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
            FontAwesomeIcons.pen,
            size: 18.0,
          ),
        ),
      ], isBack: false,
    ));
  }

  _buildRootListView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        controller: _controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildSearchBar();
          } else if (index == 1) {
            return _buildStoriesList();
          } else {
            return ConversationItem(
              friendItem: friendList[index - 2], dateFormat: '',
            );
          }
        },
        itemCount: friendList.length + 2,
      ),
    );
  }

  _buildSearchBar() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: SearchBar(),
    );
  }

  _buildStoriesList() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 16.0),
      child: const StoriesList(),
    );
  }
}
