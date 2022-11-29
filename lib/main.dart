import 'package:facebook/blocs/app_cubit.dart';
import 'package:facebook/blocs/navigation/navigation_cubit.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/network/api_client_facebook.dart';
import 'package:facebook/network/api_util.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:overlay_support/overlay_support.dart';

import 'router/application.dart';
import 'router/routers.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key) {
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

  @override
  void initState() {
    super.initState();
    _navigationCubit = NavigationCubit();
    _apiClient = ApiUtil.getApiClient();
  }

  @override
  void dispose() {
    _navigationCubit!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (context) {
            return AuthRepositoryImpl(_apiClient);
          }),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (context) {
              final _authRepository =
                  RepositoryProvider.of<AuthRepository>(context);
              return AppCubit(authRepository: _authRepository);
            })
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
