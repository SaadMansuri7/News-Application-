import 'dart:async';

import 'package:newsapp/baseViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsViewmodel extends BaseViewModel {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Completer<WebViewController> get controller => _controller;

  void setWebViewController(WebViewController webViewController) {
    if (!_controller.isCompleted) {
      _controller.complete(webViewController);
    }
    notifyListeners();
  }
}
