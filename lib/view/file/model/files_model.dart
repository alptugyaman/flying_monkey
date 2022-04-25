import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'files_model.g.dart';

@JsonSerializable()
class Files {
  String? name;
  int? size;
  String? extension;
  String? uploadTime;
  String? link;

  Files({
    this.name,
    this.size,
    this.extension,
    this.uploadTime,
    this.link,
  });

  Files.fromQuery(QueryDocumentSnapshot<Files> e) {
    name = e['name'];
    size = e['size'];
    extension = e['extension'];
    uploadTime = e['uploadTime'];
    link = e['link'];
  }

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

  Map<String, dynamic> toJson() => _$FilesToJson(this);
}
