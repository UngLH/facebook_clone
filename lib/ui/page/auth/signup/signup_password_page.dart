import 'dart:async';

import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/ui/page/auth/signup/signup_cubit.dart';
import 'package:facebook/ui/widgets/app_bar.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/ui/widgets/app_snackbar.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:facebook/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../router/application.dart';

class SignUpPasswordPage extends StatefulWidget {
  final SignUpCubit cubit;
  const SignUpPasswordPage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPasswordPageState();
  }
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription _loadingSubscription;

  SignUpCubit get _cubit => widget.cubit;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: "");

  bool isShowPassword = true;

  @override
  void initState() {
    _loadingSubscription = _cubit.loadingController.stream.listen((event) {
      if (event == LoadingStatus.LOADING) {
        context.loaderOverlay.show();
      } else if (event == LoadingStatus.SUCCESS) {
        context.loaderOverlay.hide();
        _showMessage("Tạo tài khoản thành công!");
        Application.router?.navigateTo(context, Routes.login, clearStack: true);
      } else {
        context.loaderOverlay.hide();
        _showMessage("Xin vui lòng thử lại!");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _loadingSubscription.cancel();
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
      appBar: AppBarWidget(context: context, title: "Mật khẩu"),
      body: BlocBuilder<SignUpCubit, SignUpState>(
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
                                      labelText: "Mật khẩu",
                                      obscureText: isShowPassword,
                                      padding: 0,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (!Validator.validatePassword(value!))
                                          return "Mật khẩu chưa đúng định dạng!";
                                        else
                                          return null;
                                      },
                                      controller: _passwordController,
                                      suffixIcon: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap: () {
                                          setState(() {
                                            isShowPassword = !isShowPassword;
                                          });
                                        },
                                        child: Icon(
                                          isShowPassword
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
                                title: "Tiếp",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _cubit.passwordChange(
                                        _passwordController.text);
                                    await _cubit.signUp();
                                    if (_cubit.state.loadingStatus ==
                                        LoadingStatus.FAILURE) {
                                      print("error");
                                    }
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
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
