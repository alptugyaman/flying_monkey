import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/files_model.dart';

class FileTable extends StatefulWidget {
  final FilesDataSource filesDataSource;

  const FileTable({Key? key, required this.filesDataSource}) : super(key: key);

  @override
  State<FileTable> createState() => _FileTableState();
}

class _FileTableState extends State<FileTable> {
  final int _rowsPerPage = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _grid(),
        _pager(),
      ],
    );
  }

  SfDataGrid _grid() {
    return SfDataGrid(
      source: widget.filesDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      rowsPerPage: _rowsPerPage,
      columns: <GridColumn>[
        _gridColumn('name'),
        _gridColumn('size'),
        _gridColumn('type'),
        _gridColumn('time'),
        _gridColumn('file'),
      ],
    );
  }

  SfDataPager _pager() {
    return SfDataPager(
      delegate: widget.filesDataSource,
      pageCount: _getPageCount(),
      direction: Axis.horizontal,
    );
  }

  double _getPageCount() {
    return ((widget.filesDataSource._filesData.length / _rowsPerPage).ceil())
        .toDouble();
  }

  GridColumn _gridColumn(String title) {
    return GridColumn(
      columnName: title,
      label: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

class FilesDataSource extends DataGridSource {
  FilesDataSource({required List<Files> filesData}) {
    _filesData = filesData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'size', value: e.size),
              DataGridCell<String>(columnName: 'type', value: e.extension),
              DataGridCell<String>(columnName: 'time', value: e.uploadTime),
              DataGridCell<String>(columnName: 'file', value: e.link),
            ]))
        .toList();
  }

  List<DataGridRow> _filesData = [];

  @override
  List<DataGridRow> get rows => _filesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return _cellTap(e);
    }).toList());
  }

  InkWell _cellTap(DataGridCell<dynamic> e) {
    return InkWell(
      onTap: e.columnName == 'file' ? () => openFile(e.value) : null,
      child: _cells(e),
    );
  }

  Container _cells(DataGridCell<dynamic> e) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: e.columnName != 'file'
          ? Text(
              e.value.toString(),
              style: const TextStyle(fontSize: 10),
            )
          : const Icon(Icons.arrow_circle_right_outlined),
    );
  }

  Future<void> openFile(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);

    OpenFile.open(file.path);
  }
}
