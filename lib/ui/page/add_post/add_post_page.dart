import 'dart:async';
import 'dart:io';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'add_post_cubit.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddPostPageState();
  }
}

class _AddPostPageState extends State<AddPostPage> {
  AddPostCubit? _cubit;
  late StreamSubscription _loadingSubscription;
  final statusController = TextEditingController(text: "");

  @override
  void initState() {
    _cubit = BlocProvider.of<AddPostCubit>(context);
    _loadingSubscription = _cubit!.loadingController.stream.listen((event) {
      if (event == LoadStatus.LOADING) {
        context.loaderOverlay.show();
      } else if (event == LoadStatus.SUCCESS) {
        context.loaderOverlay.hide();
        Application.router
            ?.navigateTo(context, Routes.homeTab, clearStack: true);
        _showMessage("Thành công!");
      } else {
        context.loaderOverlay.hide();
        _showMessage("Đã có lỗi xảy ra!");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _loadingSubscription.cancel();
    statusController.dispose();
    super.dispose();
  }

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  final List<dynamic> _mediaImageShow = [];
  final List<XFile> _mediaImagePicker = [];

  final List<XFile> _mediaVideoPicker = [];
  final List<File> _fileImageUpload = [];
  final List<File> _fileVideoUpload = [];
  var search = false;

  PickedFile? imageFile = null;

  // Get from gallery
  _openGallery(BuildContext context) async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles!.isNotEmpty) {
      if (pickedFiles.length <= 4) {
        _mediaImageShow.addAll(pickedFiles);
        _mediaImagePicker.addAll(pickedFiles);
      } else {
        for (int i = 0; i < 4; i++) {
          _mediaImageShow.add(pickedFiles[i]);
          _mediaImagePicker.add(pickedFiles[i]);
        }
        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
          message: "Đã quá số lượng cho phép!",
        ));
      }
    }
    setState(() {});
    // Navigator.pop(context);
  }

  // Get from Camera
  void _openCamera(BuildContext context) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile!.path.isNotEmpty) {
      _mediaImageShow.add(pickedFile);
    }
    setState(() {});
  }

  void _openVideoGallery(BuildContext context) async {
    final XFile? pickedFiles =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFiles!.path.isNotEmpty) {
      _mediaVideoPicker.add(pickedFiles);
      final uint8list = await VideoThumbnail.thumbnailData(
        video: pickedFiles.path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 128,
        // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 100,
      );
      _mediaImageShow.add(uint8list);
    }
    setState(() {});
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
      message: message,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 1,
          title: const Text(
            "Tạo bài viết",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: AppColors.background,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                  onPressed: () {
                    _mediaImagePicker.forEach((element) {
                      _fileImageUpload.add(File(element.path));
                      print(element.path);
                    });
                    _mediaVideoPicker.forEach((element) {
                      _fileVideoUpload.add(File(element.path));
                    });
                    _cubit!.addPost(statusController.text, "hạnh phúc",
                        _fileImageUpload, _fileVideoUpload);
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(60),
                      backgroundColor: AppColors.main,
                      elevation: 1),
                  child: const Text("Đăng")),
            ),
          ],
        ),
        body: BlocBuilder<AddPostCubit, AddPostState>(
          bloc: _cubit,
          buildWhen: (previous, current) =>
              previous.loadingStatus != current.loadingStatus,
          builder: (context, state) {
            return LoaderOverlay(
              useDefaultLoading: true,
              child: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppColors.grayBackground,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    AppImages.icDefaultUser,
                                    color: Colors.white,
                                    width: 45,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Lê Hồng Ưng",
                                style: AppTextStyle.blackS16Bold,
                              )
                            ],
                          ),
                        ),
                        TextField(
                          controller: statusController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLines: _mediaImageShow.isEmpty ? 10 : 1,
                          cursorHeight: 25,
                          cursorColor: AppColors.blueIconButton,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 0),
                              hintText: "Bạn đang nghĩ gì?",
                              hintStyle: TextStyle(
                                color: AppColors.grayText,
                                fontSize: 20,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        Container(
                          child: _mediaImageShow.isEmpty
                              ? Center(child: SizedBox())
                              : (_mediaImageShow.length == 1
                                  ? _mediaImageFile(_mediaImageShow[0], 0)
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: _mediaImageShow.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _mediaImageFile(
                                            _mediaImageShow[index], index);
                                      })),
                        ),
                        menuItem(
                            title: "Ảnh",
                            icon: AppImages.icImage,
                            onPressed: () async {
                              if (_mediaImageShow.length <= 4) {
                                _openGallery(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(AppSnackBar(
                                  message: "Đã đạt đến số lượng cho phép!",
                                ));
                              }
                            }),
                        menuItem(
                            title: "Gắn thẻ người khác",
                            icon: AppImages.icTagFriend,
                            color: AppColors.main),
                        menuItem(
                            title: "Cảm xúc/Hoạt động",
                            icon: AppImages.icEmotion),
                        menuItem(title: "Check in", icon: AppImages.icCheckIn),
                        menuItem(
                            title: "Video",
                            icon: AppImages.icLiveStream,
                            onPressed: () async {
                              _openVideoGallery(context);
                            }),
                        menuItem(title: "Màu nền", icon: AppImages.icFont),
                        menuItem(
                            title: "Camera",
                            icon: AppImages.icCamera,
                            color: AppColors.main),
                        menuItem(
                            title: "File GIF",
                            icon: AppImages.icGIF,
                            color: const Color(0xFF4BB7A8)),
                        menuItem(
                            title: "Nhạc",
                            icon: AppImages.icMusic,
                            color: Colors.deepOrange),
                      ],
                    ),
                  )),
            );
          },
        ));
  }

  Widget menuItem(
      {String? icon, String? title, Color? color, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderColor))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  icon ?? AppImages.icImage,
                  width: 30,
                  color: color,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$title",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mediaImageFile(var imageFile, int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          child: (Stack(
        children: <Widget>[
          imageFile.runtimeType == XFile
              ? Image.file(
                  File(imageFile!.path),
                  width: MediaQuery.of(context).size.width,
                  height: 290,
                  fit: BoxFit.fitWidth,
                )
              : Image.memory(
                  imageFile,
                  width: MediaQuery.of(context).size.width,
                  height: 290,
                  fit: BoxFit.fitWidth,
                ),
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: const Icon(Icons.close, size: 22, color: Colors.white),
              splashColor: Colors.blue.withAlpha(30),
              onPressed: () {
                setState(() {
                  _mediaImageShow.removeAt(index);
                });
              },
            ),
          )
        ],
      ))),
    );
  }

  Widget _mediaVideoFile(var imageFile, int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          child: (Stack(
        children: <Widget>[
          Image.file(
            File(imageFile!.path),
            width: MediaQuery.of(context).size.width,
            height: 290,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: const Icon(Icons.close, size: 22, color: Colors.white),
              splashColor: Colors.blue.withAlpha(30),
              onPressed: () {
                setState(() {
                  _mediaImageShow.removeAt(index);
                });
              },
            ),
          )
        ],
      ))),
    );
  }
}
