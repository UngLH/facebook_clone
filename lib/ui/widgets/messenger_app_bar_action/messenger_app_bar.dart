import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_bar_network_rounded_image.dart';

// ignore: must_be_immutable
class MessengerAppBarAction extends StatefulWidget {
  List<Widget>? actions = <Widget>[];
  String? title;
  bool? isScroll;
  bool? isBack;
  String? subTitle;
  String? imageUrl;

  MessengerAppBarAction({Key? key, 
    this.actions,
    this.title = '',
    this.isScroll,
    this.isBack,
    this.subTitle,
    this.imageUrl,
  }) : super(key: key);

  @override
  _MessengerAppBarActionState createState() => _MessengerAppBarActionState();
}

class _MessengerAppBarActionState extends State<MessengerAppBarAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.only(right: 12.0, top: 25.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: widget.isScroll! ? Colors.black12 : Colors.white,
          offset: const Offset(0.0, 1.0),
          blurRadius: 10.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FontAwesomeIcons.chevronLeft,
                    size: 25.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 16.0,
              ),
              AppBarNetworkRoundedImage(
                imageUrl: widget.imageUrl!,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      widget.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.subTitle!,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  )
                ],
              )
            ],
          ),
          Row(
            children: widget.actions!
                .map((c) => Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: c,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
