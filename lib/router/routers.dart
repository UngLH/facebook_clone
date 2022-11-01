import 'package:fluro/fluro.dart';
import 'router_handlers/auth_router_handler.dart';
import 'router_handlers/root_router_handler.dart';

class Routes  {
  static String root = "/";

  /// Auth
  static String login = "/login";


  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notHandler;
    // router.define(root, handler: splashHandler);

    router.define(
      root,
      handler: splashHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}