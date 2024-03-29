import 'package:facebook/ui/page/conversations/chat_detail/chat_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  final _messageController = TextEditingController(text: "");
  ChatDetailCubit? _cubit;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<ChatDetailCubit>(context);
    super.initState();
  }

  BorderRadiusGeometry _messageStyle(int index) {
    var current = _cubit!.state.chatDetailList![index].isYour!;
    var prev = index > 0 ? _cubit!.state.chatDetailList![index - 1].isYour! : null;
    var next = index < _cubit!.state.chatDetailList!.length - 1 ? _cubit!.state.chatDetailList![index + 1].isYour! : null;
    if (current) {
      if (prev != current && next != current) {
        return BorderRadius.circular(30);
      } else if (prev != current && next == current) {
        return const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));
      } else if (prev == current && next != current) {
        return const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), topRight: Radius.circular(30));
      } else {
        return const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30));
      }
    } else {
      if (prev != current && next != current) {
        return BorderRadius.circular(30);
      } else if (prev != current && next == current) {
        return const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30), topRight: Radius.circular(30));
      } else if (prev == current && next != current) {
        return const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30), topRight: Radius.circular(30));
      } else {
        return const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
        builder: (context, state) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Expanded(
                child: _cubit!.state.chatDetailList!.length! != 0 ?
                  ListView.builder(
                  padding: const EdgeInsets.only(top: 8.0),
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 2.0,
                      ),
                      child: Slidable(
                        key: const ValueKey(0),
                        enabled: _cubit!.state.chatDetailList![index].isYour! ? true : false,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: _cubit!.state.chatDetailList![index].isYour!
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            !_cubit!.state.chatDetailList![index].isYour! &&
                                (_cubit!.state.chatDetailList![index].isYour! !=
                                  _cubit!.state.chatDetailList![index == state.chatDetailList!.length - 1 ? index : index + 1].isYour!
                                || (index == state.chatDetailList!.length - 1))
                              ? AppBarNetworkRoundedImage(
                                  imageUrl: widget.friendItem.partner!.avatar!)
                              : const SizedBox(width: 40.0),
                            const SizedBox(width: 15.0),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _cubit!.state.chatDetailList![index].isYour! ? Colors.lightBlue : Colors.grey.shade200,
                                borderRadius: _messageStyle(index)
                              ),
                              child: Text(
                                _cubit!.state.chatDetailList![index].message!,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _cubit!.state.chatDetailList![index].isYour! ? Colors.white : Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        endActionPane: ActionPane(
                          extentRatio: 0.4,
                          dragDismissible: false,
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {}),
                          children: _cubit!.state.chatDetailList![index].isYour!
                            ? [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: Colors.red,
                                icon: Icons.restore_from_trash,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: Colors.blueAccent,
                                icon: Icons.reply,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ]
                          : []
                        ),
                      ),
                    );
                  },
                  itemCount: _cubit!.state.chatDetailList!.length,
                )
                :
                  Column(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    Center(
                      child: Container(
                        width: 160.0,
                        height: 160.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          image: DecorationImage(
                            image: AssetImage(widget.friendItem.partner!.avatar!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        widget.friendItem.partner!.username!,
                        style: const TextStyle(
                          fontSize: 32.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Facebook",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Các bạn là bạn bè trên Facebook",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              _buildBottomChat(),
            ],
          ),
        ),
      )
    );
  }

  _buildAppBar() {
    return MessengerAppBarAction(
      isScroll: _isScroll,
      isBack: true,
      listFriendModel: widget.friendItem,
      subTitle: 'Active 10 hours ago',
      actions: const <Widget>[
        Icon(
          Icons.phone,
          color: Colors.lightBlue,
          size: 30.0,
        ),
        Icon(
          Icons.info,
          color: Colors.lightBlue,
          size: 30.0,
        ),
      ],
    );
  }

  _buildBottomChat() {
    FocusNode myFocusNode = FocusNode();
    return BlocBuilder<ChatDetailCubit, ChatDetailState>(
        builder: (context, state) => Container(
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
                  Icons.image,
                  size: 30.0,
                  color: Colors.lightBlue,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: TextField(
                autofocus: false,
                focusNode: myFocusNode,
                controller: _messageController,
                onChanged: (value) => {
                  _cubit!.messageValueChange(_messageController.text)
                },
                onSubmitted: (value){
                  if (_cubit!.state.messageValue!.isNotEmpty) {
                    _cubit!.sendMessage();
                    _messageController.clear();
                    myFocusNode.requestFocus();
                  }
                },
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
                      Icons.sentiment_satisfied_alt,
                      size: 30.0,
                      color: Colors.lightBlue,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () {
                  if (_cubit!.state.messageValue!.isNotEmpty) {
                    _cubit!.sendMessage();
                    _messageController.clear();
                    myFocusNode.requestFocus();
                  }
                },
                icon: _cubit!.state.messageValue!.isNotEmpty
                  ? const Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.lightBlue,
                    )
                  : const Icon(
                      Icons.thumb_up_alt,
                      size: 30.0,
                      color: Colors.lightBlue,
                    ),
              ),
            )
          ],
        ),
      )
    );
  }
}
