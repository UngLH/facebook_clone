import 'package:json_annotation/json_annotation.dart';

part 'image_entity.g.dart';

@JsonSerializable()
class ImageEntity {
  String? id;
  String? url;
  ImageEntity({this.id, this.url});

  ImageEntity copyWith({String? id, String? url}) {
    return ImageEntity(id: id ?? this.id, url: url ?? this.url);
  }

  factory ImageEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ImageEntityToJson(this);
}

@JsonSerializable()
class VideoEntity {
  String? thumb;
  String? url;
  VideoEntity({this.thumb, this.url});

  VideoEntity copyWith({String? thumb, String? url}) {
    return VideoEntity(thumb: thumb ?? this.thumb, url: url ?? this.url);
  }

  factory VideoEntity.fromJson(Map<String, dynamic> json) =>
      _$VideoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VideoEntityToJson(this);
}
