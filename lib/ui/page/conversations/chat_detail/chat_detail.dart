import 'package:facebook/models/entities/conversations/chat_detail_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/widgets/messenger_app_bar/app_bar_network_rounded_image.dart';
import 'package:facebook/ui/widgets/messenger_app_bar_action/messenger_app_bar.dart';

// ignore: must_be_immutable
class ChatDetail extends StatefulWidget {
  ListFriendModel friendItem;
  ChatDetail({Key? key, required this.friendItem}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final _isScroll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 2.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: chatDetailList[index].isYour!
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: <Widget>[
                        !chatDetailList[index].isYour! &&
                            (chatDetailList[index].isYour! !=
                              chatDetailList[index == chatDetailList.length - 1 ? index : index + 1].isYour!
                            || index == chatDetailList.length - 1)
                          ? AppBarNetworkRoundedImage(
                              imageUrl: widget.friendItem.imageAvatarUrl!)
                          : const SizedBox(width: 40.0),
                        const SizedBox(width: 15.0),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            chatDetailList[index].message!,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: chatDetailList.length,
              ),
            ),
            _buildBottomChat(),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return MessengerAppBarAction(
      isScroll: _isScroll,
      isBack: true,
      title: widget.friendItem.name!,
      imageUrl: widget.friendItem.imageAvatarUrl!,
      subTitle: 'Active 10 hours ago',
      actions: const <Widget>[
        Icon(
          FontAwesomeIcons.phoneAlt,
          color: Colors.lightBlue,
          size: 20.0,
        ),
        Icon(
          FontAwesomeIcons.infoCircle,
          color: Colors.lightBlue,
          size: 20.0,
        ),
      ],
    );
  }

  _buildBottomChat() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.image,
                size: 25.0,
                color: Colors.lightBlue,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: 'Aa',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  suffixIcon: const Icon(
                    FontAwesomeIcons.solidSmileBeam,
                    size: 25.0,
                    color: Colors.lightBlue,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.solidThumbsUp,
                size: 25.0,
                color: Colors.lightBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
