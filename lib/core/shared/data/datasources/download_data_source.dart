import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';

abstract class DownloadDataSource {
  downloadFile(String url, {required String name});
}

class DownloadDataSourceImplementation implements DownloadDataSource {
  @override
  downloadFile(String url, {required String name}) async {
    final status = await Permission.storage.request();

    if (!status.isGranted) {
      return;
    }

    final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;
    String dirPath = directory!.path;
    final fileName = name + '.jpg';
    final savePath = '$dirPath/$fileName';
    final savedDir = Directory(savePath);

    AppHelpers.logMe(savedDir.path);
    try {
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        await savedDir.create();
      }
      Future.delayed(const Duration(seconds: 2));
      FlutterDownloader.registerCallback(downloadCallback);
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedDir.path,
        fileName: fileName,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
      );
    } catch (e) {
      rethrow;
    }
  }
}
