import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/signup/signup_cubit.dart';
import 'package:facebook/ui/widgets/app_bar.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/utils/validators.dart';
import 'package:flutter/material.dart';

class SignUpPhonePage extends StatefulWidget {
  final SignUpCubit cubit;
  const SignUpPhonePage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPhonePageState();
  }
}

class _SignUpPhonePageState extends State<SignUpPhonePage>
    with AutomaticKeepAliveClientMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SignUpCubit get _cubit => widget.cubit;

  final _phoneNumberController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context, title: "Số điện thoại"),
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
                        "Nhập số điện thoại của bạn",
                        style: AppTextStyle.blackS18Bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nhập số điện thoại để liện hệ của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân sau.",
                        style: AppTextStyle.blackS16,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _phoneNumberController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (Validator.validateNullOrEmpty(value!))
                                  return "Vui lòng nhập một số điện thoại hợp lệ";
                                else
                                  return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Số điện thoại",
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
                        onPressed: () {
                          // print(_cubit.state.fullName);
                          if (_formKey.currentState!.validate()) {
                            _cubit.phoneChange(_phoneNumberController.text);
                            // print(_cubit!.state.phoneNumber);
                            Application.router?.navigateTo(
                                context, Routes.signUpPassword,
                                routeSettings:
                                    RouteSettings(arguments: _cubit));
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
