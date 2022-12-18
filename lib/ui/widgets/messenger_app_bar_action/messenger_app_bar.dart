import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/story_detail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessengerAppBarAction extends StatefulWidget {
  List<Widget>? actions = <Widget>[];
  bool? isScroll;
  bool? isBack;
  String? subTitle;
  ListFriendModel? listFriendModel;

  MessengerAppBarAction({Key? key, 
    this.actions,
    this.isScroll,
    this.isBack,
    this.subTitle,
    this.listFriendModel,
  }) : super(key: key);

  @override
  _MessengerAppBarActionState createState() => _MessengerAppBarActionState();
}

class _MessengerAppBarActionState extends State<MessengerAppBarAction> {
  _buildBorder() {
    if (widget.listFriendModel!.isActive!) {
      return Border.all(color: Colors.grey.shade300, width: 3);
    } else {
      return Border.all(color: Colors.blue, width: 3);
    }
  }

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
                    Icons.chevron_left,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 16.0,
              ),
              _buildConversationImage(),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      
                    },
                    child: SizedBox(
                      width: 120.0,
                      child: Text(
                        widget.listFriendModel!.name!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
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

  _buildConversationImage() {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => StoryDetail(listFriendModel: widget.listFriendModel!)));
        },
        child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: _buildBorder(),
          image: DecorationImage(
            image: AssetImage(widget.listFriendModel!.imageAvatarUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
