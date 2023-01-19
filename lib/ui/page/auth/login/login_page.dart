import 'dart:async';

import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../widgets/app_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription _showMessageSubscription;
  late StreamSubscription _loadingSubscription;

  final _usernameController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");

  bool isShowPassword = true;
  LoginCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LoginCubit>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    _showMessageSubscription =
        _cubit!.showMessageController.stream.listen((event) {
      _showMessage(event);
    });
    _loadingSubscription = _cubit!.loadingController.stream.listen((event) {
      if (event == LoadingStatus.LOADING) {
        context.loaderOverlay.show();
      } else if (event == LoadingStatus.SUCCESS) {
        context.loaderOverlay.hide();
        Application.router
            ?.navigateTo(context, Routes.homeTab, clearStack: true);
      } else {
        context.loaderOverlay.hide();
        _showMessage("Thông tin tài khoản mật khẩu không chính xác!");
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
    passwordController.dispose();
    _showMessageSubscription.cancel();
    _loadingSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        body: (BlocBuilder<LoginCubit, LoginState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus,
            builder: (context, state) {
              return LoaderOverlay(
                useDefaultLoading: true,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            AppImages.icLoginBackground,
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      AppTextFieldUnderLine(
                        hintText: "Số điện thoại hoặc email",
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppPasswordField(
                          hintText: "Mật khẩu",
                          obscureText: isShowPassword,
                          controller: passwordController,
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
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButton(
                        color: AppColors.main,
                        splashColor: Colors.black,
                        onPressed: () async {
                          await _cubit!.signIn(_usernameController.text,
                              passwordController.text);
                          if (_cubit!.state.loadingStatus ==
                              LoadingStatus.SUCCESS) {
                            Application.router?.navigateTo(
                              context,
                              Routes.homeTab,
                            );
                          }
                        },
                        title: "Đăng nhập",
                        border: 5,
                        width: MediaQuery.of(context).size.width - 60,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Quên mật khẩu?",
                            style: TextStyle(
                                color: AppColors.darkMain,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 60,
                            height: 1,
                            color: Colors.grey,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text("HOẶC"),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width / 2) - 60,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      AppButton(
                        color: AppColors.greenButtonColor,
                        border: 5,
                        onPressed: () {
                          Application.router
                              ?.navigateTo(context, Routes.signUpIntro);
                        },
                        width: MediaQuery.of(context).size.width - 80,
                        title: "Tạo tài khoản Facebook mới",
                      )
                    ],
                  ),
                ),
              );
            })));
  }
}
