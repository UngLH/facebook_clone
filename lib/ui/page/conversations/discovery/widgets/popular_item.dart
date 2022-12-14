import 'package:flutter/material.dart';
import 'package:facebook/models/entities/conversations/popular_list.dart';

class PopularItem extends StatefulWidget {
  final Popular popularItem;
  const PopularItem({ Key ?key, required this.popularItem}) : super(key: key);

  @override
  _PopularItemState createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          _buildConversationImage(),
          _buildTitleAndLatestMessage(),
        ],
      ),
    );
  }

  _buildTitleAndLatestMessage() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildConverastionTitle(),
            const SizedBox(height: 2),
            _buildTextContent(widget.popularItem.note),
            const SizedBox(height: 2),
            _buildTextContent(widget.popularItem.description),
          ],
        ),
      ),
    );
  }

  _buildConverastionTitle() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.popularItem.title!,
        style: const TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildTextContent(content) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        content,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14.0),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildConversationImage() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
        image: DecorationImage(
          image: AssetImage(widget.popularItem.imgUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
