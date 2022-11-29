
#Facebook Clone
Flutter Facebook Clone. This is a simple flutter application where I have clonned Facebook UI.

* [API Documments](https://documenter.getpostman.com/view/13814248/TVsoGqXp#630163c2-a1c1-4bde-bb62-4446ea237318)

# Installation
Link API: 
* lib/configs/app_configs.dart
```
static const baseUrl = "http://10.0.2.2:5000";
```
 Run commands to start: 
```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run lib/main.dart
```

#Basic Flutter Components
 * [Flutter doc](https://docs.flutter.dev/development/ui/widgets-intro)

#API docs
* [Retrofit](https://pub.dev/packages/retrofit)
* [JsonSerializable](https://pub.dev/packages/json_serializable)

Create Entity  by JsonSerializable

Example: lib/models/entities/login/login_entity.dart

```
import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  String? id;
  String? username;
  String? token;
  String? avatar;
  String? active;

  LoginEntity({this.id, this.username, this.token, this.avatar, this.active});

  LoginEntity copyWith({
    String? id,
    String? username,
    String? token,
    String? avatar,
    String? active,
  }) {
    return LoginEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        token: token ?? this.token,
        avatar: avatar ?? this.avatar,
        active: active ?? this.active);
  }

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
```
Run command to generate "login_entity.g.dart" : 
```
flutter pub run build_runner watch
```
#State management 
* [Bloc](https://pub.dev/packages/flutter_bloc)
* [Ví dụ về Cubit Flutter - State Management](https://baoflutter.com/cubit-flutter-state-management-cach-quan-ly-state-voi-cubit/#:~:text=Cubit%20l%C3%A0%20m%E1%BB%99t%20trong%20nh%E1%BB%AFng,%C4%91%E1%BB%99%20m%C6%B0%E1%BB%A3t%20cho%20%E1%BB%A9ng%20d%E1%BB%A5ng.)






# Create new screen:

Khi tạo một màn hình mới, để tiện cho việc debug giao diện, chưa nên thêm Bloc vào screen.
Để hiển thị màn hình mới :
Example: 
* lib/ui/page/home/home_page.dart
```
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}

```
* main.dart
```
import 'package:facebook/ui/page/home/home_page.dart';

/// add this row in GetMaterialApp()
home: MenuPage(),
```


    


