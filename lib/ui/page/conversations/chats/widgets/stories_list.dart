import 'package:facebook/commons/app_images.dart';
import 'package:facebook/ui/page/conversations/chats/widgets/story_detail.dart';
import 'package:flutter/material.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';

class StoriesList extends StatefulWidget {
  final List<ListFriendModel> friendList;
  const StoriesList({Key? key, required this.friendList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoriesListState();
  }
}

class _StoriesListState extends State<StoriesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const AddToYourStoryButton();
        } else {
          print(widget.friendList);
          return StoryListItem(
              friendItem: widget.friendList[index - 1], friendIndex: index);
        }
      },
      itemCount: widget.friendList.length + 1,
    );
  }
}

class StoryListItem extends StatefulWidget {
  final ListFriendModel friendItem;
  final int friendIndex;
  const StoryListItem({Key? key, required this.friendItem, required this.friendIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StoryListItemState();
  }
}

class _StoryListItemState extends State<StoryListItem> {
  _buildBorder() {
    if (widget.friendItem.isActive!) {
      return Border.all(color: Colors.grey.shade300, width: 3);
    } else {
      return Border.all(color: Colors.blue, width: 3);
    }
  }

  _getTextStyle() {
    if (widget.friendItem.isActive!) {
      return _viewedStoryListItemTextStyle();
    } else {
      return _notViewedStoryListItemTextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: _buildBorder(),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StoryDetail(listFriendModel: widget.friendItem)));
                },
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                      image: AssetImage(widget.friendItem.partner!.avatar ?? AppImages.icFacebookLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 60.0,
              child: Text(
                widget.friendItem.partner!.username!,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: _getTextStyle(),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12.0)
      ],
    );
  }
}

class AddToYourStoryButton extends StatelessWidget {
  const AddToYourStoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 35.0,
                  )),
              const SizedBox(height: 8.0),
              Text('Your story', style: _viewedStoryListItemTextStyle()),
            ],
          ),
          const SizedBox(width: 12.0)
        ],
      ),
    );
  }
}

_notViewedStoryListItemTextStyle() {
  return const TextStyle(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
}

_viewedStoryListItemTextStyle() {
  return const TextStyle(fontSize: 12, color: Colors.grey);
}
