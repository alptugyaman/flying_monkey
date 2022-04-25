import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../core/component/dialog/error_dialog.dart';
import '../../view/file/model/files_model.dart';

class FirebaseService {
  static Future<UploadTask?> uploadFile(
    BuildContext context,
    String destination,
    File file,
  ) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      await ErrorDialog(error: e).show(context);

      return null;
    }
  }

  static Future<void> saveFileDetails(Files files) async {
    final firestore = FirebaseFirestore.instance.collection('files').doc();
    firestore.set(files.toJson());
  }

  static Stream<QuerySnapshot<Files>> getFiles() {
    final files = FirebaseFirestore.instance
        .collection('files')
        .orderBy('uploadTime', descending: true)
        .withConverter<Files>(
          fromFirestore: (snapshots, _) => Files.fromJson(snapshots.data()!),
          toFirestore: (files, _) => files.toJson(),
        );

    return files.snapshots();
  }
}
