import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;

class CameraFeed extends StatefulWidget {
  final String streamUrl;
  final VoidCallback? onError; // Callback when stream fails
  final VoidCallback? onLoad;  // Optional: when it loads successfully

  const CameraFeed({
    super.key,
    required this.streamUrl,
    this.onError,
    this.onLoad,
  });

  @override
  State<CameraFeed> createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  late final String viewId;

  @override
  void initState() {
    super.initState();
    viewId = 'camera-feed-${widget.streamUrl.hashCode}-${DateTime.now().millisecondsSinceEpoch}';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final imgElement = html.ImageElement()
        ..src = widget.streamUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..onError.listen((event) {
          widget.onError?.call();
        })
        ..onLoad.listen((event) {
          widget.onLoad?.call();
        });

      return imgElement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 640,
      height: 480,
      child: HtmlElementView(viewType: viewId));
  }
}
