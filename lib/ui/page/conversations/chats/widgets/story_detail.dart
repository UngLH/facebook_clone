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
  final _messageController = TextEditingController(text: "");

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.listFriendModel.partner!.username!),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: StoryView(
                    storyItems: widget.listFriendModel.stories!.map((e) {
                      return e.text != null
                          ? StoryItem.text(
                              title: e.text!,
                              backgroundColor: Colors.black,
                            )
                          : StoryItem.pageProviderImage(AssetImage(e.imageUrl!),
                              imageFit: BoxFit.contain);
                    }).toList(),
                    onStoryShow: (s) {},
                    onComplete: () {
                      Navigator.pop(context);
                    },
                    progressPosition: ProgressPosition.top,
                    repeat: false,
                    controller: storyController,
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(child: _buildBottomChat())),
          ],
        ));
  }

  _buildBottomChat() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (value) => {
                if (_messageController.text.isNotEmpty)
                  {storyController.pause()}
                else
                  {storyController.play()}
              },
              style: const TextStyle(color: Colors.white70),
              onSubmitted: (value) {},
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
                fillColor: const Color.fromARGB(50, 238, 238, 238),
                hintStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        size: _messageController.text.isEmpty ? 0.0 : 25.0,
                        color: Colors.lightBlue,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.thumb_up_alt,
                size: 25.0,
                color: Color.fromARGB(210, 3, 168, 244),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                size: 25.0,
                color: Color.fromARGB(210, 244, 67, 54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.emoji_emotions,
                size: 25.0,
                color: Color.fromARGB(210, 255, 255, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
