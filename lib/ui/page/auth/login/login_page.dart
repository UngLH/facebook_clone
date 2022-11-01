import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController(text: "");
  final passwordController = TextEditingController(text:"");
  bool isShowPassword = true;
  LoginCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          physics:const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: AppColors.darkMain,
                child: Center(
                  child: Container(
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Center(
                          child: Image.asset(
                        AppImages.icWhiteLogo,
                        width: 40,
                      ))),
                ),
              ),
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
                  customBorder:const CircleBorder() ,
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
                  )

              ),
              const SizedBox(
                height: 20,
              ),

              AppButton(
                color: AppColors.main,
                splashColor: Colors.black,
                onPressed: () async {
                await  _cubit!.signIn(_usernameController.text, passwordController.text);
                },
                title: "Đăng nhập",
                border: 5,
                width: MediaQuery.of(context).size.width - 60,
              ),
              TextButton(
                  onPressed: () {
                    print("Quên mật khẩu!");
                  },
                  child: const Text(
                    "Quên mật khẩu?",
                    style: TextStyle(
                        color: AppColors.darkMain, fontWeight: FontWeight.bold),
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
                color: AppColors.green2A,
                border: 5,
                onPressed: (){
                  print("Tạo tài khoản");
                },
                width: MediaQuery.of(context).size.width - 80,
                title: "Tạo tài khoản Facebook mới",
              )
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: "Số điện thoại hoặc email",
              //     enabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide( width: 2,
              //           color: AppColors.darkMain), //<-- SEE HERE
              //     ),
              //   ),
              //   cursorColor: AppColors.darkMain,
              //
              //
              // ),
            ],
          ),
        ));
  }
}
