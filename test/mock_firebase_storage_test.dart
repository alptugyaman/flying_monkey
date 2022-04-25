import 'dart:io';

import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:test/test.dart';

const String imageName = 'someImage.png';
const String fileName = 'someFile.pdf';
const String url = 'gs://some-bucket/';

void main() {
  group('MockFirebaseStorage Tests', () {
    test('Upload Image', () async {
      final storage = MockFirebaseStorage();
      final storageRef = storage.ref().child(imageName);
      final image = File(imageName);
      final task = storageRef.putFile(image);
      await task;

      expect(task.snapshot.ref.fullPath, equals('$url$imageName'));
    });

    test('Check Image', () async {
      final storage = MockFirebaseStorage();
      final storageRef = storage.ref().child(imageName);
      final image = File(imageName);
      final task = storageRef.putFile(image);
      await task;

      expect(storage.storedFilesMap.containsKey('/$imageName'), isTrue);
    });

    test('Upload File And Get It', () async {
      final storage = MockFirebaseStorage();
      final storageRef = storage.ref().child(fileName);
      final file = File(fileName);
      final task = storageRef.putFile(file);
      await task;

      expect(task.snapshot.ref.fullPath, equals('$url$fileName'));
    });

    test('Check File', () async {
      final storage = MockFirebaseStorage();
      final storageRef = storage.ref().child(fileName);
      final file = File(fileName);
      final task = storageRef.putFile(file);
      await task;

      expect(storage.storedFilesMap.containsKey('/$fileName'), isTrue);
    });
  });
}
