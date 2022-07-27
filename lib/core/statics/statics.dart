import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';

import '../utilities/utilities.dart';

part 'assets.dart';
part 'colors.dart';
part 'configs.dart';
part 'dimensions.dart';
part 'enums.dart';
part 'extensions.dart';

void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}
