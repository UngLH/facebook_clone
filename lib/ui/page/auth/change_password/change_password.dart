import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/change_password/change_password_cubit.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:facebook/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../widgets/app_snackbar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPageState();
  }
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription _showMessageSubscription;
  late StreamSubscription _loadingSubscription;

  final _newPasswordController = TextEditingController(text: "");
  final _oldPasswordController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  bool isShowOldPassword = true;
  bool isShowNewPassword = true;
  ChangePasswordCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ChangePasswordCubit>(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _showMessageSubscription =
        _cubit!.showMessageController.stream.listen((event) {
      _showMessage(event);
    });
    _loadingSubscription = _cubit!.loadingController.stream.listen((event) {
      if (event == LoadStatus.LOADING) {
        context.loaderOverlay.show();
      } else if (event == LoadStatus.SUCCESS) {
        context.loaderOverlay.hide();
        SharedPreferencesHelper.removeTokenAndUserId();
        _showMessage("Thay đổi mật khẩu thành công!");
        Application.router?.navigateTo(
          context,
          Routes.root,
        );
      } else {
        context.loaderOverlay.hide();
        _showMessage("Mật khẩu cũ chưa chính xác!");
      }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(
      message: message,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _showMessageSubscription.cancel();
    _loadingSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
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
              "Thay đổi mật khẩu",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            )),
        body: (BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) {
              return LoaderOverlay(
                useDefaultLoading: true,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Chọn mật khẩu",
                                  style: AppTextStyle.blackS18Bold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tạo mật khẩu dài tối thiểu 6 ký tự. Đó phải là mật khẩu mà người khác không thể đoán được",
                                  style: AppTextStyle.blackS16,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: AppPasswordField(
                                        labelText: "Mật khẩu cũ",
                                        obscureText: isShowOldPassword,
                                        padding: 0,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (!Validator.validatePassword(
                                              value!))
                                            return "Mật khẩu chưa đúng định dạng!";
                                          else
                                            return null;
                                        },
                                        controller: _oldPasswordController,
                                        suffixIcon: InkWell(
                                          customBorder: const CircleBorder(),
                                          onTap: () {
                                            setState(() {
                                              isShowOldPassword =
                                                  !isShowOldPassword;
                                            });
                                          },
                                          child: Icon(
                                            isShowOldPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: AppPasswordField(
                                        labelText: "Mật khẩu mới",
                                        obscureText: isShowNewPassword,
                                        padding: 0,
                                        autoValidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (!Validator.validatePassword(
                                              value!))
                                            return "Mật khẩu chưa đúng định dạng!";
                                          else
                                            return null;
                                        },
                                        controller: _newPasswordController,
                                        suffixIcon: InkWell(
                                          customBorder: const CircleBorder(),
                                          onTap: () {
                                            setState(() {
                                              isShowNewPassword =
                                                  !isShowNewPassword;
                                            });
                                          },
                                          child: Icon(
                                            isShowNewPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                AppButton(
                                  title: "Xác nhận",
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _cubit!.changePassword(
                                          _oldPasswordController.text,
                                          _newPasswordController.text);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}
