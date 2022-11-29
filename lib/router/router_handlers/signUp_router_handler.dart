import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/signup/signup_cubit.dart';
import 'package:facebook/ui/page/auth/signup/signup_intro_page.dart';
import 'package:facebook/ui/page/auth/signup/signup_name_page.dart';
import 'package:facebook/ui/page/auth/signup/signup_password_page.dart';
import 'package:facebook/ui/page/auth/signup/signup_phone_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Handler signUpIntroHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SignUpIntroPage(),
);
Handler signUpFullNameHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<AuthRepository>(context);
      return SignUpCubit(authRepository: repository);
    },
    child: const SignUpNamePage(),
  );
});
Handler signUpPhoneNumberHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  SignUpCubit cubit = context!.settings!.arguments as SignUpCubit;
  return SignUpPhonePage(
    cubit: cubit,
  );
});

Handler signUpPasswordHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  SignUpCubit cubit = context!.settings!.arguments as SignUpCubit;
  return SignUpPasswordPage(
    cubit: cubit,
  );
  // return BlocProvider(
  //   create: (context) {
  //     final repository = RepositoryProvider.of<AuthRepository>(context);
  //     return SignUpCubit(authRepository: repository);
  //   },
  //   child: const SignUpPasswordPage(),
  // );
});
