import 'package:facebook/ui/page/conversations/chats/widgets/story_detail.dart';
import 'package:flutter/material.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';

class PeopleCard extends StatefulWidget {
  const PeopleCard({Key? key, required this.peopleItem, required this.indexItem}) : super(key: key);

  final ListFriendModel peopleItem;
  final int indexItem;
  @override
  _PeopleCardState createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => 
          StoryDetail(listFriendModel: widget.peopleItem)
        ));
      },
      child:Container(
        height: 600.0,
        margin: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          bottom: 16.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(widget.peopleItem.imageAvatarUrl!),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.6),
                Colors.black.withOpacity(.3),
              ],
              stops: const [0.1, 0.9],
              begin: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    width: 2.0,
                    color: widget.peopleItem.isActive!
                        ? Colors.blue.shade700
                        : Colors.transparent,
                  ),
                ),
                child: Container(
                  width: 46.0,
                  height: 46.0,
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(23.0),
                    image: DecorationImage(
                      image: AssetImage(widget.peopleItem.imageAvatarUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                widget.indexItem == 0 ? 'Thêm tin mới' : widget.peopleItem.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
