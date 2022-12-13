import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

// ignore: constant_identifier_names
const ListYourFriendChat = ['Hello', 'Nice to meet you!'];
// ignore: constant_identifier_names
const ListYourChat = ['Hi', 'Nice to meet you!'];

class _ProfileState extends State<Profile> {
  bool _isScroll = false;
  late ScrollController _controller;

  _scrollListener() {
    if (_controller.offset > 0) {
      setState(() {
        _isScroll = true;
      });
    } else {
      setState(() {
        _isScroll = false;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        // onNotification: (overscroll) {
        //   overscroll.disallowGlow();
        // },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Center(
                        child: Container(
                          width: 160.0,
                          height: 160.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: const DecorationImage(
                              image: AssetImage('yourAccount.avatarImg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Center(
                        child: Text(
                          'fb.com/hoang2k1111',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildTitleSetting('Account'),
                      _buildSettingItem('Username', '@hoang2k1111', true),
                      _buildSettingItem('Gender', 'Male', true),
                      _buildSettingItem(
                          'Email', 'flutterforsale@gmail.com', false),
                      _buildTitleSetting('Setting'),
                      _buildSettingItem('Notification', '', true),
                      _buildSettingItem('Privacy and Security', '', true),
                      _buildSettingItem('Language', '', true),
                      _buildSettingItem('Chat Settings', '', true),
                      _buildSettingItem('Help', '', false),
                      const SizedBox(height: 16.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.only(right: 12.0, top: 16.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: _isScroll ? Colors.black12 : Colors.white,
          offset: const Offset(0.0, 1.0),
          blurRadius: 10.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(
                  FontAwesomeIcons.solidEdit,
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildTitleSetting(title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey.shade300),
            bottom: BorderSide(width: 0.5, color: Colors.grey.shade300),
          )),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      ),
    );
  }

  _buildSettingItem(title, subtitle, isBorderBottom) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: isBorderBottom ? 0.5 : 0.0,
          color: isBorderBottom ? Colors.grey.shade300 : Colors.transparent,
        ),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.grey.shade500,
                size: 18.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
