import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/auth/signup/signup_cubit.dart';
import 'package:facebook/ui/widgets/app_bar.dart';
import 'package:facebook/ui/widgets/app_button.dart';
import 'package:facebook/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpNamePage extends StatefulWidget {
  const SignUpNamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpNamePageState();
  }
}

class _SignUpNamePageState extends State<SignUpNamePage>
    with AutomaticKeepAliveClientMixin {
  SignUpCubit? _cubit;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController(text: "");
  final _firstNameController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SignUpCubit>(context);
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context, title: "Tên"),
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
                        "Tên bạn là gì?",
                        style: AppTextStyle.blackS18Bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nhập tên của bạn sử dụng trong đời thực",
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
                              validator: (value) {
                                if (Validator.validateNullOrEmpty(value!))
                                  return "Vui lòng nhập họ và tên của bạn";
                                else
                                  return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _firstNameController,
                              decoration:
                                  const InputDecoration(labelText: "Tên"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (Validator.validateNullOrEmpty(value!))
                                  return "Vui lòng nhập họ của bạn";
                                else
                                  return null;
                              },
                              controller: _lastNameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration:
                                  const InputDecoration(labelText: "Họ"),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      AppButton(
                        title: "Tiếp",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _cubit!.fullNameChange(_firstNameController.text,
                                _lastNameController.text);
                            Application.router?.navigateTo(
                                context, Routes.signUpPhoneNumber,
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
