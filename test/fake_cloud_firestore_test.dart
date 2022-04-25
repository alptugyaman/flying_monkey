import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';
import 'document_snapshot_matcher.dart';
import 'query_snapshot_matcher.dart';

const uid = 'fileId';

Map<String, dynamic> _fileMap = {
  "name": "imageName1",
  "size": 1000000,
  "extension": "jpg",
  "uploadTime": "24/04/2022 15:00",
  "link":
      "gs://flyingdonkey-ee7c1.appspot.com/files/4B33CB85-87B0-4098-B82F-C3EEDE2176A9.jpeg"
};

void main() {
  group('dump', () {
    const expectedDumpAfterset = '''{
  "files": {
    "fileId": {
      "name": "imageName1",
      "size": 1000000,
      "extension": "jpg",
      "uploadTime": "24/04/2022 15:00",
      "link": "gs://flyingdonkey-ee7c1.appspot.com/files/4B33CB85-87B0-4098-B82F-C3EEDE2176A9.jpeg"
    }
  }
}''';

    test('Sets data for a document within a collection', () async {
      final instance = FakeFirebaseFirestore();
      await instance.collection('files').doc(uid).set(_fileMap);
      expect(instance.dump(), equals(expectedDumpAfterset));
    });

    test('brackets to read a field', () async {
      final instance = FakeFirebaseFirestore();
      final docRef = instance.doc('file/imageName1');
      await docRef.set(_fileMap);
      expect((await docRef.get())['name'], equals('imageName1'));
    });

    test('Snapshots fire an empty array for empty collections', () async {
      final instance = FakeFirebaseFirestore();
      final collectionsRef = instance.collection('files').withConverter(
          fromFirestore: (_, __) => 'Something', toFirestore: (_, __) => {});
      collectionsRef.snapshots().listen(expectAsync1((snap) {
        expect(snap.size, equals(0));
      }));
    });

    test('Snapshots returns a Stream of Snapshots', () async {
      final instance = FakeFirebaseFirestore();
      await instance.collection('files').doc(uid).set(_fileMap);
      expect(
          instance.collection('files').snapshots(),
          emits(QuerySnapshotMatcher(
              [DocumentSnapshotMatcher('fileId', _fileMap)])));
    });
  });
  test('Snapshots sets exists property to false if the document does not exist',
      () async {
    final instance = FakeFirebaseFirestore();
    await instance.collection('users').doc(uid).set(_fileMap);
    instance
        .collection('files')
        .doc('doesnotexist')
        .snapshots()
        .listen(expectAsync1((document) {
      expect(document.exists, equals(false));
    }));
  });

  test('Snapshots sets exists property to true if the document does  exist',
      () async {
    final instance = FakeFirebaseFirestore();
    await instance.collection('files').doc(uid).set(_fileMap);
    instance
        .collection('files')
        .doc(uid)
        .snapshots()
        .listen(expectAsync1((document) {
      expect(document.exists, equals(true));
    }));
  });
}
