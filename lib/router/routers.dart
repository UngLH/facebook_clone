import 'package:facebook/router/router_handlers/home_router_handler.dart';
import 'package:facebook/router/router_handlers/signUp_router_handler.dart';
import 'package:fluro/fluro.dart';

import 'router_handlers/auth_router_handler.dart';
import 'router_handlers/root_router_handler.dart';

class Routes {
  static String root = "/";

  /// Auth
  static String login = "/login";

  /// Sign up
  static String signUpIntro = '/signUpIntro';
  static String signUpName = '/signUpName';
  static String signUpPhoneNumber = '/signUpPhone';
  static String signUpPassword = '/signUpPassword';

  /// Home
  static String homeTab = "/homeTab";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notHandler;
    // router.define(root, handler: splashHandler);

    router.define(
      root,
      handler: splashHandler,
      transitionType: TransitionType.fadeIn,
    );

    /// Auth
    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.fadeIn,
    );

    /// Sign up
    router.define(
      signUpIntro,
      handler: signUpIntroHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      signUpName,
      handler: signUpFullNameHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      signUpPhoneNumber,
      handler: signUpPhoneNumberHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      signUpPassword,
      handler: signUpPasswordHandler,
      transitionType: TransitionType.inFromRight,
    );

    /// Home
    router.define(
      homeTab,
      handler: homeTabHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
