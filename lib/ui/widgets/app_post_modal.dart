import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class ModalPostWidget extends StatefulWidget {
  VoidCallback deletePost;
  VoidCallback editPost;
  ModalPostWidget({
    required this.deletePost,
    required this.editPost,
    Key? key,
  }) : super(key: key);

  @override
  State<ModalPostWidget> createState() => _ModalPostWidgetState();
}

class _ModalPostWidgetState extends State<ModalPostWidget> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  late double heightResize = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * heightResize,
      decoration: const BoxDecoration(
          color: AppColors.roundIconButtonBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            _modalItem(iconData: Icons.push_pin_rounded, text: "Ghim bài viết"),
            _modalItem(iconData: Icons.bookmark, text: "Lưu bài viết"),
            _modalItem(
                iconData: Icons.edit,
                text: "Chỉnh sửa bài viết",
                function: widget.editPost),
            _modalItem(
                iconData: Icons.delete,
                text: "Xóa bài viết",
                function: widget.deletePost),
          ],
        ),
      ),
    );
  }

  Widget _modalItem(
      {IconData? iconData, String? text, VoidCallback? function}) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text ?? "Ghim bài viết",
              style:
                  AppTextStyle.blackS20.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
