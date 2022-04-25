import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/component/dialog/error_dialog.dart';
import '../../../product/firebase/firebase_service.dart';
import '../../../product/utils/utils.dart';
import '../model/files_model.dart';

part 'file_view_model.g.dart';

class FileViewModel = FileViewModelBase with _$FileViewModel;

abstract class FileViewModelBase with Store {
  File? file;
  @observable
  UploadTask? task;

  @action
  Future<void> saveAFile(BuildContext context) async {
    try {
      await Permission.photos.request();

      var status = await Permission.storage.request();

      if (status.isGranted || status.isLimited) {
        final _picker = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'docx'],
        );

        if (_picker == null) return;

        final path = _picker.files.single.path!;
        file = File(path);

        if (file == null) return;

        final fileName = basename(file!.path);
        final destination = 'files/$fileName';

        task = await FirebaseService.uploadFile(context, destination, file!);

        if (task == null) return;

        final snapshot = await task!;
        final urlDownload = await snapshot.ref.getDownloadURL();

        var _files = Files()
          ..name = _picker.files.first.name
          ..size = _picker.files.first.size
          ..extension = _picker.files.first.extension
          ..uploadTime = Utils.dateToString(DateTime.now())
          ..link = urlDownload;

        await FirebaseService.saveFileDetails(_files);
      }
    } on Exception catch (e) {
      ErrorDialog(error: e).show(context);
    }
  }

  @action
  Future<void> openFile(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);

    OpenFile.open(file.path);
  }

  @action
  void clearCache() {
    DefaultCacheManager().emptyCache();
  }

  @action
  void removeFile(url) {
    DefaultCacheManager().removeFile(url).then((value) {
      if (kDebugMode) {
        print('File removed');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
