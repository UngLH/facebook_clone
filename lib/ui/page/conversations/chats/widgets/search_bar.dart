import 'package:facebook/ui/page/conversations/chats/list_friend_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  ListFriendCubit? _cubit;
  final _searchValueController = TextEditingController(text: "");

  @override
  void dispose() {
    _searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ListFriendCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: <Widget>[
          Container(width: 10.0,),
          const Icon(Icons.search),
          Container(width: 8.0,),
          Expanded(
            child: TextField(
              autofocus: false,
              controller: _searchValueController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search'
              ),
              onChanged: (value) => {
                _cubit!.searchValueChange(_searchValueController.text)
              },
            ),
          ),
        ],
      ),
    );
  }
}