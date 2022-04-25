import 'package:flutter/material.dart';

import '../circular_progress/button_circular.dart';

typedef FutureCallBack = Future<void> Function();

class FloatingLoadingButton extends StatefulWidget {
  const FloatingLoadingButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.tag,
  }) : super(key: key);

  final String title;
  final String tag;
  final FutureCallBack onPressed;
  @override
  _FloatingLoadingButtonState createState() => _FloatingLoadingButtonState();
}

class _FloatingLoadingButtonState extends State<FloatingLoadingButton> {
  bool _isLoading = false;
  final Color _buttonColor = Colors.grey.shade700;
  final TextStyle _textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  void _changeIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _completeAction() async {
    _changeIsLoading();
    await widget.onPressed();
    _changeIsLoading();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: widget.tag,
      backgroundColor: _buttonColor,
      onPressed: _isLoading ? null : _completeAction,
      label: _isLoading
          ? const CustomCircularProgress()
          : Text(widget.title, style: _textStyle),
    );
  }
}
