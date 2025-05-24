import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/views/details/details_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
// ignore: must_be_immutable
class DetailsViewScreen extends StatelessWidget {
  String? link;
  DetailsViewScreen({required this.link}) {
    this.link = link;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DetailsViewmodel(),
        builder: (context, _) {
          final model = context.watch<DetailsViewmodel>();
          final controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(link!));
          return Scaffold(
              appBar: AppBar(), body: WebViewWidget(controller: controller));
        });
  }
}
