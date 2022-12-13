import 'package:facebook/router/application.dart';
import 'package:flutter/material.dart';
import 'package:facebook/router/routers.dart';

import 'app_bar_network_rounded_image.dart';
import 'app_bar_title.dart';

// ignore: must_be_immutable
class MessengerAppBar extends StatefulWidget {
  List<Widget> actions = <Widget>[];
  String title;
  bool isScroll;
  bool isBack;

  MessengerAppBar(
      {Key? key, required this.actions,
      this.title = '',
      required this.isScroll,
      required this.isBack}) : super(key: key);

  @override
  _MessengerAppBarState createState() => _MessengerAppBarState();
}

class _MessengerAppBarState extends State<MessengerAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.only(right: 12.0, top: 25.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: widget.isScroll ? Colors.black12 : Colors.white,
          offset: const Offset(0.0, 1.0),
          blurRadius: 10.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 16.0,
              ),
              InkWell(
                onTap: () {
                  Application.router?.navigateTo(
                    context,
                    Routes.conversation_profile,
                  );
                },
                child: const AppBarNetworkRoundedImage(
                  imageUrl: 'yourAccount.avatarImg',
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              AppBarTitle(
                text: widget.title,
              ),
            ],
          ),
          Row(
            children: widget.actions
                .map((c) => Container(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: c,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
