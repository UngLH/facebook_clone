import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/conversations/chat_detail/chat_detail_cubit.dart';
import 'package:facebook/ui/page/conversations/chats/list_friend_cubit.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/story_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/ui/page/conversations/chat_detail/chat_detail.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatefulWidget {
  final ListFriendCubit? cubit_;
  final ListFriendModel friendItem;
  final String dateFormat;
  const ConversationItem({Key? key, required this.friendItem, required this.dateFormat, required this.cubit_})
      : super(key: key);

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  _buildBorder() {
    if (widget.friendItem.isActive!) {
      return Border.all(color: Colors.grey.shade300, width: 3);
    } else {
      return Border.all(color: Colors.blue, width: 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Slidable(
        key: const ValueKey(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              _buildConversationImage(),
              _buildTitleAndLatestMessage(),
            ],
          ),
        ),
        startActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.blue,
              icon: Icons.camera_alt,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey.shade300,
              icon: Icons.phone,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey.shade300,
              icon: Icons.videocam,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey.shade300,
              icon: Icons.menu,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.grey.shade300,
              icon: Icons.notifications,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              icon: Icons.restore_from_trash,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleAndLatestMessage() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => 
                BlocProvider(
                  create: (context) {
                    final repository = RepositoryProvider.of<AuthRepository>(context);
                    return ChatDetailCubit(authRepository: repository);
                  },
                  child: ChatDetail(friendItem: widget.friendItem),
                )
            ),
          );
          widget.cubit_!.createConversation(widget.friendItem);
        } ,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildConverastionTitle(),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildLatestMessage(),
                  _buildTimeOfLatestMessage()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildConverastionTitle() {
    return Text(
      widget.friendItem.partner!.username!,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  _buildLatestMessage() {
    return SizedBox(
      width: 120.0,
      child: Text(
        widget.friendItem.lastMessage!.message!,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildTimeOfLatestMessage() {
    if (widget.friendItem.lastMessage!.created!.isEmpty) {
      return const Text("");
    }
    int timestamp = int.parse(widget.friendItem.lastMessage!.created!);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var d12 = DateFormat('dd-MM-yyyy, hh:mm a').format(date);
    return Text(d12.toString(),
        style: TextStyle(color: Colors.grey.shade700, fontSize: 11));
  }

  _buildConversationImage() {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => StoryDetail(listFriendModel: widget.friendItem)));
        },
        child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: _buildBorder(),
          image: DecorationImage(
            image: AssetImage(widget.friendItem.partner!.avatar!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
