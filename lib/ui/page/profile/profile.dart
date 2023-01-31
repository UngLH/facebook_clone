import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/profile/profile_add_photo_modal.dart';
import 'package:facebook/ui/page/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  String? userId;

  ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileCubit? _cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? userIdFromStorage;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ProfileCubit>(context);
    _cubit!.getUserProfile(widget.userId);
    getUserId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onReFreshData() async {
    _cubit!.getUserProfile(widget.userId);
  }

  Future<void> getUserId() async {
    userIdFromStorage = await SharedPreferencesHelper.getUserId();
  }

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  XFile? avatarFile;
  XFile? backgroundFile;

  PickedFile? imageFile;

  // Get from gallery
  _openGalleryAvt(BuildContext context) async {
    final XFile? pickedFileGallery =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFileGallery!.path.isNotEmpty) {
      pickedFile = pickedFileGallery;
      Navigator.of(context).pop();
      _cubit!.setUserAvt(File(pickedFileGallery.path), widget.userId);
    }
    setState(() {});
    // Navigator.pop(context);
  }

  // Get from Camera
  _openCameraAvt(BuildContext context) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    _cubit!.setUserBackground(File(file!.path), widget.userId);
    setState(() {});
  }

  _openGalleryBg(BuildContext context) async {
    final XFile? pickedFileGallery =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFileGallery!.path.isNotEmpty) {
      pickedFile = pickedFileGallery;
      Navigator.of(context).pop();
      _cubit!.setUserBackground(File(pickedFileGallery.path), widget.userId);
    }
    setState(() {});
    // Navigator.pop(context);
  }

  // Get from Camera
  _openCameraBg(BuildContext context) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    _cubit!.setUserBackground(File(file!.path), widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double avtWidth = 170;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: AppColors.borderColor, width: 1)),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Trang cá nhân",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            )),
        body: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadProfileStatus != current.loadProfileStatus,
            builder: (context, state) {
              if (state.loadProfileStatus == LoadStatus.LOADING) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.main,
                  ),
                );
              } else if (state.loadProfileStatus == LoadStatus.FAILURE) {
                return const Center(child: Text("Đã có lỗi xảy ra!"));
              } else {
                if (state.userProfile != null) {
                  print(state.userProfile!.coverImage);
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 250,
                            width: widthScreen,
                            child: Stack(
                              children: [
                                state.userProfile!.coverImage == null
                                    ? Image.asset(
                                        AppImages.icLoginBackground,
                                        height: 200,
                                        width: widthScreen,
                                        fit: BoxFit.fill,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: state.userProfile!.coverImage
                                            .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, _) =>
                                            Image.asset(
                                          AppImages.icLoginBackground,
                                          height: 200,
                                          width: widthScreen,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  left: 10,
                                  child: Column(
                                    children: [
                                      state.userProfile!.avatar == null
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: avtWidth,
                                              height: avtWidth,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.grayBackground,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 5),
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                AppImages.icDefaultUser,
                                                color: Colors.white,
                                                width: avtWidth - 20,
                                              ))
                                          : CachedNetworkImage(
                                              imageUrl: state
                                                  .userProfile!.avatar
                                                  .toString(),
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    width: avtWidth,
                                                    height: avtWidth,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context, _) =>
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: avtWidth,
                                                      height: avtWidth,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .grayBackground,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 5),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Image.asset(
                                                        AppImages.icDefaultUser,
                                                        color: Colors.white,
                                                        width: avtWidth - 20,
                                                      ))),
                                    ],
                                  ),
                                ),
                                widget.userId == userIdFromStorage
                                    ? Positioned(
                                        bottom: 10,
                                        left: 145,
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                backgroundColor: AppColors
                                                    .commentBackgroundColor,
                                                builder: (context) {
                                                  return ModalProfilePhotoWidget(
                                                    openGallery: () {
                                                      _openGalleryAvt(context);
                                                    },
                                                    openCamera: () {
                                                      _openCameraAvt(context);
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grayBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                                Icons.camera_alt_rounded),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                widget.userId == userIdFromStorage
                                    ? Positioned(
                                        top: 150,
                                        right: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                backgroundColor: AppColors
                                                    .commentBackgroundColor,
                                                builder: (context) {
                                                  return ModalProfilePhotoWidget(
                                                    openGallery: () {
                                                      _openGalleryBg(context);
                                                    },
                                                    openCamera: () {
                                                      _openCameraBg(context);
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grayBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                                Icons.camera_alt_rounded),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              state.userProfile!.username ??
                                  "Nguời dùng facebook",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Colors.black),
                            ),
                          ),
                          const Divider(
                            color: AppColors.grayBackground,
                            thickness: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Thông tin cá nhân",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _infor(Icons.description_rounded,
                                    text: state.userProfile!.description ==
                                            "chưa có mô tả"
                                        ? "Giới thiệu bản thân"
                                        : state.userProfile!.description),
                                const SizedBox(
                                  height: 10,
                                ),
                                _infor(Icons.home_rounded,
                                    text: (state.userProfile!.city == null &&
                                            state.userProfile!.country == null)
                                        ? "Địa chỉ"
                                        : "${state.userProfile!.city ?? ""} ${state.userProfile!.country ?? ""}"),
                                const SizedBox(
                                  height: 10,
                                ),
                                widget.userId == userIdFromStorage
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  String? userId =
                                                      await SharedPreferencesHelper
                                                          .getUserId();
                                                  bool status = await Application.router?.navigateTo(
                                                      context,
                                                      Routes.profileEdit,
                                                      routeSettings: RouteSettings(
                                                          arguments: EditPageArgument(
                                                              userId: userId,
                                                              username: state
                                                                  .userProfile!
                                                                  .username,
                                                              description: state
                                                                  .userProfile!
                                                                  .description,
                                                              country: state
                                                                  .userProfile!
                                                                  .country,
                                                              city: state
                                                                  .userProfile!
                                                                  .city,
                                                              address: state
                                                                  .userProfile!
                                                                  .address,
                                                              website: state
                                                                  .userProfile!
                                                                  .link)));
                                                  if (status) {
                                                    _onReFreshData();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor: AppColors
                                                        .commentBackgroundColor),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Chỉnh sửa chi tiết",
                                                      style: AppTextStyle
                                                          .blackS16Bold,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: AppColors.grayBackground,
                            thickness: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Danh sách bạn bè",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    GestureDetector(
                                      child: const Text(
                                        "Tất cả",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.main),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 20,
                                      mainAxisExtent: 140,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 180,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "https://img.freepik.com/free-photo/cheerful-beautiful-young-asian-woman-feeling-happy-smiling-camera-while-traveling-chinatown-beijing-china_7861-1341.jpg?w=1380&t=st=1675048893~exp=1675049493~hmac=53b2305347e6b6f13c2d5b37754ad4c19a32ee96d90b17bb8607300f2f7c79d2",
                                                width: 110,
                                                height: 110,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Lê Hồng Ưng",
                                              style: AppTextStyle.blackS16Bold,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text("Đã có lỗi xảy ra!"));
                }
              }
            }));
  }

  Widget _infor(IconData iconData, {String? text}) {
    return Row(
      children: [
        Icon(
          // Icons.description_rounded,
          iconData,
          color: AppColors.grayIconButton,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
