import 'package:facebook/router/router_handlers/conversation_handler.dart';
import 'package:facebook/router/router_handlers/friend_router_handler.dart';
import 'package:facebook/router/router_handlers/home_router_handler.dart';
import 'package:facebook/router/router_handlers/profile_router_handler.dart';
import 'package:facebook/router/router_handlers/post_router_handler.dart';
import 'package:facebook/router/router_handlers/searchHandler.dart';
import 'package:facebook/router/router_handlers/signUp_router_handler.dart';
import 'package:fluro/fluro.dart';

import 'router_handlers/auth_router_handler.dart';
import 'router_handlers/root_router_handler.dart';

class Routes {
  static String root = "/";

  /// Auth
  static String login = "/login";
  static String changePassword = "/changePassword";

  /// Sign up
  static String signUpIntro = '/signUpIntro';
  static String signUpName = '/signUpName';
  static String signUpPhoneNumber = '/signUpPhone';
  static String signUpPassword = '/signUpPassword';
  static String conversation = '/conversation';
  static String conversation_detail = '/conversation/chatDetail';
  static String conversation_profile = '/conversation/profile';
  static String profile = '/profile';
  static String profileEdit = '/profileEdit';

  /// Home
  static String homeTab = "/homeTab";

  ///Post
  static String addPost = "/addPost";
  static String editPost = "/editPost";

  /// Friend
  static String suggestFriends = "/suggestFriends";
  static String listBlockFriends = "/listBlockFriends";

  // Search
  static String search = "/search";
  static String searchResult = "/searchResult";

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

    /// Change password
    router.define(
      changePassword,
      handler: changePasswordHandler,
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

    ///Post
    router.define(addPost,
        handler: addPostHandler, transitionType: TransitionType.inFromBottom);
    router.define(addPost,
        handler: addPostHandler, transitionType: TransitionType.inFromBottom);
    router.define(editPost,
        handler: editPostHandler, transitionType: TransitionType.inFromBottom);

    /// Conversation
    router.define(conversation,
        handler: conversationHandler, transitionType: TransitionType.cupertino);
    router.define(conversation_detail,
        handler: conversationDetailHandler,
        transitionType: TransitionType.inFromRight);
    router.define(conversation_profile,
        handler: conversationProfileHandler,
        transitionType: TransitionType.inFromRight);

    /// Friend
    router.define(listBlockFriends,
        handler: listBlockFriendsHandler,
        transitionType: TransitionType.inFromBottom);

    router.define(suggestFriends,
        handler: suggestFriendHandler,
        transitionType: TransitionType.inFromBottom);

    /// Profile

    router.define(
      profile,
      handler: profileHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      profileEdit,
      handler: profileEditHandler,
      transitionType: TransitionType.fadeIn,
    );

    /// search
    router.define(
      search,
      handler: searchHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      searchResult,
      handler: searchResultHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
