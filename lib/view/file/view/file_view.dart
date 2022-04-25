import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/component/circular_progress/button_circular.dart';
import '../../../core/component/button/floating_loading_button.dart';
import '../../../product/firebase/firebase_service.dart';
import '../model/files_model.dart';
import '../viewmodel/file_view_model.dart';
import 'file_table.dart';

class FileView extends StatefulWidget {
  const FileView({Key? key}) : super(key: key);

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  late FileViewModel viewModel;

  @override
  void initState() {
    viewModel = FileViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _fileStream(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floating(context),
    );
  }

  AppBar _appBar() => AppBar(title: const Text('File Center'));

  StreamBuilder<QuerySnapshot<Files>> _fileStream() {
    return StreamBuilder<QuerySnapshot<Files>>(
      stream: FirebaseService.getFiles(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.hasData) {
          final data = snapshot.requireData;
          if (data.size > 0) {
            List<Files> _files =
                data.docs.map((e) => Files.fromQuery(e)).toList();

            return FileTable(
              filesDataSource: FilesDataSource(
                filesData: _files,
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        } else {
          return const Center(child: CustomCircularProgress());
        }
      },
    );
  }

  FloatingLoadingButton _floating(BuildContext context) {
    return FloatingLoadingButton(
      tag: 'File',
      onPressed: () async => viewModel.saveAFile(context),
      title: '+ Add File',
    );
  }
}
