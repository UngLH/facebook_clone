import 'package:flutter/material.dart';
import 'package:facebook/models/entities/conversations/popular_list.dart';
import 'package:facebook/ui/page/conversations/discovery/widgets/popular_item.dart';
import 'package:facebook/ui/page/conversations/discovery/widgets/stories_list.dart';
import 'package:facebook/ui/page/conversations/discovery/widgets/search_bar.dart';
import 'package:facebook/ui/widgets/messenger_app_bar/messenger_app_bar.dart';

class ListDicovery extends StatefulWidget {
  const ListDicovery({Key? key}) : super(key: key);

  @override
  _ListDicoveryState createState() => _ListDicoveryState();
}

class _ListDicoveryState extends State<ListDicovery> {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: <Widget>[
            MessengerAppBar(
              isScroll: _isScroll,
              title: 'Discovery',
              actions: const <Widget>[], isBack: false,
            ),
            _buildRootWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildRootWidget() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        controller: _controller,
        itemCount: popularList.length + 4,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              child: _buildSearchBar(),
            );
          } else if (index == 1) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        'Recent',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SEE MORE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            );
          } else if (index == 2) {
            return const SizedBox(
              height: 100.0,
              child: StoriesList(),
            );
          } else if (index == 3) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const <Widget>[
                  Text(
                    'Popular',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return PopularItem(popularItem: popularList[index - 4]);
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return (const Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0), child: SearchBar()));
  }
}
