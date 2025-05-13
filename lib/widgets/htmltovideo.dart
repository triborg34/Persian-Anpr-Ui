import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;

class CameraFeed extends StatelessWidget {
  final String streamUrl;

  const CameraFeed({super.key, required this.streamUrl});

  @override
  Widget build(BuildContext context) {
    // Register a unique view type
    String viewId = 'camera-feed-${streamUrl.hashCode}';

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    viewId,
    (int viewId) {
      final imgElement = html.ImageElement()
        ..src = streamUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover';
      return imgElement;
    },
  );


    return SizedBox(
      width: 640,
      height: 480,
      child: HtmlElementView(viewType: viewId),
    );
  }
}
