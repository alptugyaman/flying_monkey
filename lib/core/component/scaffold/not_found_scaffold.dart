import 'package:flutter/material.dart';

class NotFoundScaffold extends StatelessWidget {
  const NotFoundScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: const Center(
        child: Text('Sayfa Bulunamadı'),
      ),
    );
  }
}
