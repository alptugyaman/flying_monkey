import 'package:flutter/material.dart';

class NoNetworkScaffold extends StatelessWidget {
  const NoNetworkScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: const Center(
        child: Text('İnternet Bağlantısı Yok'),
      ),
    );
  }
}
