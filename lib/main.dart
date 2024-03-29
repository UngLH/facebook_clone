import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:facebook/blocs/app_cubit.dart';
import 'package:facebook/blocs/navigation/navigation_cubit.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/network/api_client_facebook.dart';
import 'package:facebook/network/api_util.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/repositories/search_repository.dart';
import 'package:facebook/repositories/user_repository.dart';
import 'package:facebook/ui/page/find/find_page.dart';
import 'package:facebook/ui/page/friend/friend_widget/add_friend_item_cubit.dart';
import 'package:facebook/ui/page/friend/home_friend/home_friends_cubit.dart';
import 'package:facebook/ui/page/friend/request/friend_request_cubit.dart';
import 'package:facebook/ui/widgets/comment/app_comment_cubit.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';

import 'router/application.dart';
import 'router/routers.dart';
import 'ui/page/friend/list_friend/list_friend_cubit.dart';
import 'ui/page/friend/suggest/friend_suggest_cubit.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool networkEnabled = true;
  NavigationCubit? _navigationCubit;
  ApiClient? _apiClient;
  OverlaySupportEntry? _overlaySupportEntry;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _navigationCubit = NavigationCubit();
    _apiClient = ApiUtil.getApiClient();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.wifi &&
        result != ConnectivityResult.mobile) {
      if (networkEnabled) {
        _overlaySupportEntry = showSimpleNotification(
          Row(
            children: const [
              Text('Không thể kết nối tới máy chủ.'),
            ],
          ),
          // contentPadding: EdgeInsets.all(1),
          leading: const Icon(Icons.wifi, color: Colors.white),
          autoDismiss: false,
          background: Colors.red,
        );
      }
      networkEnabled = false;
    } else {
      networkEnabled = true;
      _overlaySupportEntry?.dismiss(animate: true);
    }
  }

  @override
  void dispose() {
    _navigationCubit!.close();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (context) {
            return AuthRepositoryImpl(_apiClient);
          }),
          RepositoryProvider<PostRepository>(create: (context) {
            return PostRepositoryImpl(_apiClient);
          }),
          RepositoryProvider<FriendRepository>(create: (context) {
            return FriendRepositoryImpl(_apiClient);
          }),
          RepositoryProvider<UserRepository>(create: (context) {
            return UserRepositoryImpl(_apiClient);
          }),
          RepositoryProvider<SearchRepository>(create: (context) {
            return SearchRepositoryImpl(_apiClient);
          }),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (context) {
              final _authRepository =
                  RepositoryProvider.of<AuthRepository>(context);
              final _postRepository =
                  RepositoryProvider.of<PostRepository>(context);
              final _userRepository =
                  RepositoryProvider.of<UserRepository>(context);
              final _searchRepository =
                  RepositoryProvider.of<SearchRepository>(context);
              return AppCubit(
                  authRepository: _authRepository,
                  postRepository: _postRepository,
                  userRepository: _userRepository,
                  searchRepository: _searchRepository);
            }),
            BlocProvider<AppCommentCubit>(
              create: (context) {
                final _postRepository =
                    RepositoryProvider.of<PostRepository>(context);
                return AppCommentCubit(repository: _postRepository);
              },
            ),
            BlocProvider<AddFriendItemCubit>(
              create: (context) {
                final _friendRepository =
                    RepositoryProvider.of<FriendRepository>(context);
                return AddFriendItemCubit(repository: _friendRepository);
              },
            ),
            BlocProvider<HomeFriendsCubit>(
              create: (context) {
                final _friendRepository =
                    RepositoryProvider.of<FriendRepository>(context);
                return HomeFriendsCubit(repository: _friendRepository);
              },
            ),
            BlocProvider<FriendRequestCubit>(
              create: (context) {
                final _friendRepository =
                    RepositoryProvider.of<FriendRepository>(context);
                return FriendRequestCubit(repository: _friendRepository);
              },
            ),
            BlocProvider<FriendSuggestCubit>(
              create: (context) {
                final _friendRepository =
                    RepositoryProvider.of<FriendRepository>(context);
                return FriendSuggestCubit(repository: _friendRepository);
              },
            ),
            BlocProvider<ListFriendCubit>(
              create: (context) {
                final _friendRepository =
                    RepositoryProvider.of<FriendRepository>(context);
                return ListFriendCubit(repository: _friendRepository);
              },
            ),
            BlocProvider<NavigationCubit>(create: (_) => _navigationCubit!)
          ],
          child: BlocListener<AppCubit, AppState>(
            listener: (context, state) {},
            child: OverlaySupport(child: materialApp()),
          ),
        ));
    // OverlaySupport(child: materialApp());
    // child: materialApp(),
  }

  GetMaterialApp materialApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
      title: AppConfig.appName,
      onGenerateRoute: Application.router!.generator,
      initialRoute: Routes.root,

      // navigatorObservers: <NavigatorObserver>[
      //   NavigationObserver(navigationCubit: _navigationCubit),
      // ],
      // supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
            /*if (Platform.isIOS) */ hideKeyboard(context);
          },
          child: MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          ),
        );
      },
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
