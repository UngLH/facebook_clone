import 'package:facebook/ui/page/profile/profile.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

/// Root
Handler profileHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      Profile(),
);
