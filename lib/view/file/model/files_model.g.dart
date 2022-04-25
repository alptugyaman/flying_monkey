// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) => Files(
      name: json['name'] as String?,
      size: json['size'] as int?,
      extension: json['extension'] as String?,
      uploadTime: json['uploadTime'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'extension': instance.extension,
      'uploadTime': instance.uploadTime,
      'link': instance.link,
    };
