import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flyingdonkey/view/file/model/files_model.dart';
import 'package:test/test.dart';

extension ExtendedFirestore on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> file(String id) {
    return collection('files').doc(id);
  }
}

final file = Files()
  ..name = 'Image1'
  ..size = 1000000
  ..extension = 'jpg'
  ..uploadTime = '24/04/2022 15:00'
  ..uploadTime =
      'gs://flyingdonkey-ee7c1.appspot.com/files/4B33CB85-87B0-4098-B82F-C3EEDE2176A9.jpeg';

void main() {
  group('Firestore Tests', () {
    test('firestore set a file', () async {
      final instance = FakeFirebaseFirestore();
      final doc = instance.file('someFileName');
      await doc.set(file.toJson());
      expect(
          (await instance
              .collection('files')
              .doc('someFileName')
              .get())['name'],
          equals('Image1'));
      expect(
          (await instance
              .collection('files')
              .doc('someFileName')
              .get())['size'],
          equals(1000000));
    });

    test('firestore set wrong file', () async {
      final instance = FakeFirebaseFirestore();
      final doc = instance.file('someFileName');
      await doc.set({});
      expect(
          (await instance
              .collection('files')
              .doc('someFileName')
              .get())['name'],
          equals(null));
    });
  });
}
