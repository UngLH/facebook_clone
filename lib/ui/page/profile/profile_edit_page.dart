import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/ui/page/profile/profile_cubit.dart';
import 'package:facebook/ui/widgets/app_snackbar.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProfileEditPage extends StatefulWidget {
  EditPageArgument? args;

  ProfileEditPage({Key? key, this.args}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileEditPageState();
  }
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileCubit? _cubit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _usernameController =
      TextEditingController(text: "");
  late TextEditingController _descriptionController =
      TextEditingController(text: "");
  late TextEditingController _countryController =
      TextEditingController(text: "");
  late TextEditingController _cityController = TextEditingController(text: "");
  late TextEditingController _addressController =
      TextEditingController(text: "");
  late TextEditingController _websiteController =
      TextEditingController(text: "");

  late StreamSubscription _loadingSubscription;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ProfileCubit>(context);
    _loadingSubscription = _cubit!.loadingController.stream.listen((event) {
      if (event == LoadStatus.LOADING) {
        context.loaderOverlay.show();
      } else if (event == LoadStatus.SUCCESS) {
        context.loaderOverlay.hide();
        _showMessage("Cập nhật thông tin thành công!");
        Navigator.of(context).pop(true);
      } else {
        context.loaderOverlay.hide();
        _showMessage("Đã có lỗi xảy ra!");
      }
    });
    widget.args!.username != null
        ? _usernameController.text = widget.args!.username.toString()
        : _usernameController = TextEditingController(text: "");
    widget.args!.description != null
        ? _descriptionController.text = widget.args!.description.toString()
        : _descriptionController = TextEditingController(text: "");
    widget.args!.country != null
        ? _countryController.text = widget.args!.country.toString()
        : _countryController = TextEditingController(text: "");
    widget.args!.city != null
        ? _cityController.text = widget.args!.city.toString()
        : _cityController = TextEditingController(text: "");
    widget.args!.address != null
        ? _addressController.text = widget.args!.address.toString()
        : _addressController = TextEditingController(text: "");
    widget.args!.website != null
        ? _websiteController.text = widget.args!.website.toString()
        : _websiteController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _descriptionController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
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
              "Chỉnh sửa thông tin cá nhân",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            )),
        body: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadProfileStatus != current.loadProfileStatus,
            builder: (context, state) {
              return LoaderOverlay(
                useDefaultLoading: true,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextFieldUnderLine(
                            labelText: "Họ và tên",
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.badge_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldUnderLine(
                            labelText: "Giới thiệu bản thân",
                            controller: _descriptionController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.description_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldUnderLine(
                            labelText: "Quốc gia",
                            controller: _countryController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.language_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldUnderLine(
                            labelText: "Thành phố",
                            controller: _cityController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.location_city_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldUnderLine(
                            labelText: "Địa chỉ",
                            controller: _addressController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.home_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextFieldUnderLine(
                            labelText: "Website",
                            controller: _websiteController,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.public_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _cubit!.setUserProfile(
                                          username: _usernameController.text,
                                          description:
                                              _descriptionController.text,
                                          address: _addressController.text,
                                          city: _cityController.text,
                                          country: _countryController.text,
                                          link: _websiteController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.main),
                                    child: Text(
                                      "Hoàn tất",
                                      style: AppTextStyle.whiteS16Bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

class EditPageArgument {
  String? userId;
  String? username;
  String? description;
  String? country;
  String? city;
  String? address;
  String? website;

  EditPageArgument(
      {this.userId,
      this.username,
      this.description,
      this.country,
      this.city,
      this.address,
      this.website});
}
