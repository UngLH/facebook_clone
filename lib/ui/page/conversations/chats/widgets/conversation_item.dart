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

class ConversationItem extends StatefulWidget {
  final ListFriendModel friendItem;
  final String dateFormat;
  const ConversationItem({Key? key, required this.friendItem, required this.dateFormat})
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
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              _buildConversationImage(),
              _buildTitleAndLatestMessage(),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SlideAction(
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SlideAction(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: SlideAction(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.videocam,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
        ],
        secondaryActions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SlideAction(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SlideAction(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SlideAction(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restore_from_trash,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleAndLatestMessage() {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.push(
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
          ),
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
      widget.friendItem.name!,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  _buildLatestMessage() {
    return SizedBox(
      width: 150.0,
      child: Text(
        widget.friendItem.shortDescription!,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildTimeOfLatestMessage() {
    return Text('1:21PM',
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
            image: AssetImage(widget.friendItem.imageAvatarUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
