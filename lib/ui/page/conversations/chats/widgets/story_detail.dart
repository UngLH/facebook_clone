import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryDetail extends StatefulWidget {
  ListFriendModel listFriendModel;
  StoryDetail({Key? key, required this.listFriendModel}) : super(key: key);

  @override
  _StoryDetailState createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listFriendModel.name!),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: StoryView(
        storyItems: widget.listFriendModel.stories!.map((e) {
          return e.text != null
            ? StoryItem.text(
                title: e.text!,
                backgroundColor: Colors.grey,
              )
            : StoryItem.pageProviderImage(
                AssetImage(e.imageUrl!),
                imageFit: BoxFit.contain
              );
        }).toList(),
        onStoryShow: (s) {
        },
        onComplete: () {
          Navigator.pop(context);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}