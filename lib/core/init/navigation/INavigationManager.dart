// ignore_for_file: file_names

abstract class INavigationManager {
  Future<void> push({String? path, Object? object});
  Future<void> pushRemove({String? path, Object? object});
}
