// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_friend_item_cubit.dart';

class AddFriendItemState extends Equatable {
  String? mode;

  AddFriendItemState({
    this.mode,
  });

  AddFriendItemState copyWith({
    String? mode,
  }) {
    return AddFriendItemState(
      mode: mode ?? this.mode,
    );
  }
  
  @override
  List<Object?> get props => [mode];
}
