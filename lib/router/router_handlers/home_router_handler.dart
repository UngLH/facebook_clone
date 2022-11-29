import 'package:facebook/ui/page/main_tab.dart';
import 'package:facebook/ui/page/splash/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

Handler homeTabHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const TabBarPage(),
);
