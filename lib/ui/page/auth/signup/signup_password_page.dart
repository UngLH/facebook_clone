import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/ui/page/auth/signup/signup_cubit.dart';
import 'package:facebook/ui/widgets/app_bar.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:facebook/utils/validators.dart';
import 'package:flutter/material.dart';

class SignUpPasswordPage extends StatefulWidget {
  final SignUpCubit cubit;
  const SignUpPasswordPage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPasswordPageState();
  }
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage>
    with AutomaticKeepAliveClientMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SignUpCubit get _cubit => widget.cubit;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: "");

  bool isShowPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context, title: "Mật khẩu"),
      body: Container(
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
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppPasswordField(
                                labelText: "Mật khẩu",
                                obscureText: isShowPassword,
                                padding: 0,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (Validator.validateNullOrEmpty(value!))
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
                                )),
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
                            _cubit.passwordChange(_passwordController.text);
                            await _cubit.signUp();
                            if (_cubit.state.loadingStatus ==
                                LoadingStatus.FAILURE) {
                              Application.router?.navigateTo(
                                context,
                                Routes.login,
                              );
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
  }

  @override
  bool get wantKeepAlive => true;
}
