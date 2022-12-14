import 'package:facebook/commons/app_images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_list.g.dart';

@JsonSerializable()
class Popular {
  int? id;
  String? imgUrl;
  String? title;
  String? description;
  String? note;

  Popular({this.id, this.imgUrl, this.title, this.description, this.note});

  Popular copyWith({
    int? id,
    String? imgUrl,
    String? title,
    String? description,
    String? note,
  }) {
    return Popular(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      note: note ?? this.note,
    );
  }

  factory Popular.fromJson(Map<String, dynamic> json) =>
      _$PopularFromJson(json);

  Map<String, dynamic> toJson() => _$PopularToJson(this);
}

var popularList = List<String>.filled(20, '')
    .asMap()
    .map((index, str) => MapEntry(
        index,
        Popular(
            id: index,
            title: "Discovery $index",
            imgUrl: AppImages.icSignupIntro,
            description: "AaAaAaAa",
            note: "Facebook note")))
    .values
    .toList();
