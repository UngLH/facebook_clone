import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/change_password/change_password.dart';
import 'package:facebook/ui/page/auth/change_password/change_password_cubit.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/ui/page/auth/login/login_page.dart';
import 'package:facebook/ui/page/splash/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Handler splashHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SplashPage(),
);

Handler loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<AuthRepository>(context);
      return LoginCubit(repository: repository);
    },
    child: const LoginPage(),
  );
});

Handler changePasswordHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(
    create: (context) {
      final repository = RepositoryProvider.of<AuthRepository>(context);
      return ChangePasswordCubit(repository: repository);
    },
    child: const ChangePasswordPage(),
  );
});
