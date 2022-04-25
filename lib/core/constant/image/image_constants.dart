class ImageConstants {
  static ImageConstants? _instance;

  static ImageConstants? get instance {
    _instance ??= ImageConstants._init();
    return _instance;
  }

  ImageConstants._init();

  String toPng(String name) => 'assets/images/$name.png';

  //PNG
  String get logo => toPng('logo');
}
