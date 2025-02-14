import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  if (await Permission.storage.request().isGranted &&
      await Permission.mediaLibrary.request().isGranted) {
    return true;
  } else {
    return false;
  }
}