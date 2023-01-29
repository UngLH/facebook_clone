import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item.dart';
import 'package:facebook/ui/widgets/empty_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'friend_request_cubit.dart';

class FriendRequestPage extends StatefulWidget{
  const FriendRequestPage({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _FriendRequestPage();
  }
  
}

class _FriendRequestPage extends State<FriendRequestPage>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FriendRequestCubit? _cubit;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _cubit = BlocProvider.of<FriendRequestCubit>(context);
    _cubit!.getListRequestFriends();
  }

   @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Lời mời kết bạn", style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.background,
        ),
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        body: BlocBuilder<FriendRequestCubit, FriendRequestState>(
        builder: (context, state) {
          if (state.loadingStatus == LoadStatus.LOADING) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.main,
              ),
            );
          } else if (state.loadingStatus == LoadStatus.FAILURE) {
            return const Center(child: Text("Đã có lỗi xảy ra!"));
          } else if (state.loadingStatus == LoadStatus.EMPTY) {
            return AppEmptyListPostPage();
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Lời mời kết bạn",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              state.listRequestFriends!.length.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30.0)),
                            child: const Text('Sắp xếp',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                          onTap: () {
                            showBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.4),
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: const Text('Mới nhất từ trước đến nay',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          _cubit!.sortIncrement();
                                          print("sort incre");
                                        },
                                      ),
                                      InkWell(
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.4),
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: const Text('Cũ nhất từ trước đến nay',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.black)),
                                        ),
                                        onTap:() {
                                          _cubit!.sortDecrement();
                                          print("sort");
                                        },
                                      )
                                    ],
                                  ) 
                                );
                              });
                              _cubit!.sortDecrement();
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.listRequestFriends!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        FriendEntity friend =
                            state.listRequestFriends![index];
                        String? avatar = friend.avatar;
                        return AddFriendItem(
                          key: UniqueKey(),
                          friendName: friend.username,
                          numMutualFriend: friend.sameFriend,
                          avtUrl: avatar,
                          acceptText: "Chấp nhận",
                          cancelText: "Từ chối",
                          accept: (() async {
                            String? token = await SharedPreferencesHelper.getToken();
                            _cubit!.repository!.setAcceptFriend(token, friend.userId, "1");
                          }),
                          cancel: (() async {
                            String? token = await SharedPreferencesHelper.getToken();
                            _cubit!.repository!.setAcceptFriend(token, friend.userId, "0");
                          }),
                        );
                      },
                      separatorBuilder: (context, state) {
                        return Container(
                          height: 0,
                        );
                      },
                    ),
                    
                  ],
                ),
              ),
            );
          }
        }
        )
    );
  }
}