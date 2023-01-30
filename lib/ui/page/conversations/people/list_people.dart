import 'package:flutter/material.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/page/conversations/people/widgets/people_card.dart';
import 'package:facebook/ui/widgets/messenger_app_bar/messenger_app_bar.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({Key? key}) : super(key: key);

  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListPeople> {
  bool _isScroll = false;
  late ScrollController _controller;

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
        return false;
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            MessengerAppBar(
              isScroll: _isScroll,
              title: 'People',
              actions: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.account_box,
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
                    Icons.person_add,
                    size: 25.0,
                  ),
                ),
              ], isBack: false,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  controller: _controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.5),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return PeopleCard(
                        peopleItem: friendList[index], indexItem: index);
                  },
                  itemCount: friendList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
