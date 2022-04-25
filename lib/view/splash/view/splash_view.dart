import 'package:flutter/material.dart';

import '../../../core/constant/image/image_constants.dart';
import '../viewmodel/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late SplashViewModel viewModel;

  @override
  void initState() {
    _animations();
    _viewModel();
    super.initState();
  }

  void _animations() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  void _viewModel() {
    viewModel = SplashViewModel();
    viewModel.route();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation);
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final _sizeTween = Tween<double>(begin: 0, end: 200);
    final animation = listenable as Animation<double>;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: SizedBox(
        child: Image.asset(ImageConstants.instance!.logo),
        height: _sizeTween.evaluate(animation) * 0.7,
        width: _sizeTween.evaluate(animation) * 0.7,
      ),
    );
  }
}
