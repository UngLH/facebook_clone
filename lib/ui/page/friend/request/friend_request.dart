import 'package:facebook/ui/page/friend/model/friend_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'friend_request_state.dart';

class FriendRequestCard extends StatefulWidget {
  FriendEntity? friendEntity;
  FriendRequestCard({Key? key, this.friendEntity}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendRequestCardState();
  }
}

class _FriendRequestCardState extends State<FriendRequestCard> {
  FriendRequestCardCubit? _cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FriendRequestCardState friendRequestCardState = FriendRequestCardState(
        code: "",
        name: widget.friendEntity!.name,
        avatarUrl: widget.friendEntity!.avatarUrl,
        created: widget.friendEntity!.created,
        sameFriends: widget.friendEntity!.sameFriends);
    _cubit = FriendRequestCardCubit(friendRequestCardState);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendRequestCardCubit, FriendRequestCardState>(
        bloc: _cubit,
        buildWhen: (previous, current) => previous.code != current.code,
        builder: (context, state) {
          if (state.code == "") {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 15.0),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/my_avatar.jpg'),
                  radius: 40.0,
                ),
                const SizedBox(width: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(state.name!,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10.0),
                    Text(state.sameFriends.toString() + "bạn chung",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(0.6))),
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('Confirm',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                          ),
                          onTap: () {
                            _cubit?.accept();
                          },
                        ),
                        const SizedBox(width: 10.0),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('Delete',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                          ),
                          onTap: () {
                            _cubit?.reject();
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          } else if (state.code == "accept") {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20.0),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/my_avatar.jpg'),
                  radius: 40.0,
                ),
                const SizedBox(width: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(state.name!,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16.0),
                    Text("Các bạn đã trở thành bạn bè",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black.withOpacity(0.6)))
                  ],
                )
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20.0),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/my_avatar.jpg'),
                  radius: 40.0,
                ),
                const SizedBox(width: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(state.name!,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15.0),
                    Text("Yêu cầu đã bị gỡ",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.6)))
                  ],
                )
              ],
            );
          }
        });
  }
}

class FriendRequest extends StatefulWidget {
  List<FriendEntity>? friendEntities;

  FriendRequest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendRequestState();
  }
}

class _FriendRequestState extends State<FriendRequest> {
  FriendRequestCubit? _cubit = FriendRequestCubit();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _cubit?.getListRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: BlocBuilder<FriendRequestCubit, FriendRequestState>(
            bloc: _cubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10, top: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text('Lời mời kết bạn',
                                  style: TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10.0),
                              Text(state.friendEntities!.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              const SizedBox(width: 20.0),
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: const Text('Sắp xếp',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15.0)),
                                ),
                                onTap: () {
                                  _cubit?.sortDecrement();
                                },
                              )
                            ],
                          ),
                          // for(FriendEntity friendEntity in state.friendEntities!)
                          //   Column(children: <Widget>[
                          //     const SizedBox(height: 20.0),
                          //     FriendRequestCard(friendEntity: friendEntity,)
                          //   ],)
                          FriendRequestCard(
                            friendEntity: state.friendEntities!.first,
                          )
                        ],
                      )),
                ),
              );
            }));
  }
}
