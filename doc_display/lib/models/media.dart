// this document will be used to define the media model
// which is mostly based on directory paths that will have a
// setter and getter.
// Media types are: PDF and Video files
// Directory Paths: _basePath, _currentPath, _pdfPath, _videoPath
// This class will extend the changeNotifierProvider class

import 'package:flutter/foundation.dart';

class MediaModel extends ChangeNotifier {
  String _basePath = '/home/pi/Documents/';
  String _currentPath = '/home/pi/Documents/';
  String _pdfPath = '/home/pi/Documents/';
  String _videoPath = '/home/pi/Documents/';

  String get basePath => _basePath;
  String get currentPath => _currentPath;
  String get pdfPath => _pdfPath;
  String get videoPath => _videoPath;

  void setCurrentPath(String path) {
    _currentPath = path;
    notifyListeners();
  }

  void setPdfPath(String path) {
    _pdfPath = path;
    notifyListeners();
  }

  void setVideoPath(String path) {
    _videoPath = path;
    notifyListeners();
  }

  void setBasePath(String path) {
    _basePath = path;
    notifyListeners();
  }
}
