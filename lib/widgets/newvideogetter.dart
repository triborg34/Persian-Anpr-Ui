import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unapwebv/widgets/htmltovideo.dart';
import 'dart:html' as html; // for memory info
// import 'package:unapwebv/widgets/videogetter.dart';


class VideoStream extends StatefulWidget {
  final String url;
  const VideoStream({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  // late WebSocket _socket;
  // Uint8List? _latestImage;
  // DateTime _lastFrameTime = DateTime.now();
  bool _isReconnecting = false;

  StreamSubscription? _frameSub;
  StreamSubscription? _reconnectSub;

  // static const int maxFrameSize = 2048 * 1024; // 300 KB

  // void connect() {
  //   _socket = WebSocket(widget.url);
  //   _socket.connect();

  //   _frameSub = _socket.stream.listen((data) {
  //     final now = DateTime.now();
  //     if (now.difference(_lastFrameTime).inMilliseconds < 100) return;
  //     _lastFrameTime = now;

  //     try {
  //       final base64String = data.toString();

  //       // Skip large base64 frames
  //       if (base64String.length > maxFrameSize * 1.37) return;

  //       final decoded = base64Decode(base64String);
  //       if (decoded.length > maxFrameSize) return;

  //       setState(() {
  //         _latestImage = decoded;
  //       });
  //     } catch (_) {
  //       // Skip corrupt frames
  //     }
  //   });

  //   _reconnectSub = _socket.reconnectingStream.listen((val) {
  //     setState(() {
  //       _isReconnecting = val;
  //     });
  //   });
  // }

  @override
  void initState() {

    
    super.initState();
    // connect();
  }

  @override
  void dispose() {
    _frameSub?.cancel();
    _reconnectSub?.cancel();
    // _socket.disconnect();
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoStream oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _frameSub?.cancel();
      _reconnectSub?.cancel();
      // _socket.disconnect();
      // connect();
    }
  }

  String getMemoryInfo() {
    try {
      final mem = html.window.performance.memory!;
      final used = (mem.usedJSHeapSize! / (1024 * 1024)).toStringAsFixed(2);
      final total = (mem.totalJSHeapSize! / (1024 * 1024)).toStringAsFixed(2);
      return "Memory: $used MB / $total MB";
    } catch (e) {
      return "Memory: N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 350,
          width: MediaQuery.of(context).size.width * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CameraFeed(streamUrl: "http://127.0.0.1:8000/video_feed/rt1",)
                // : const Center(child: CircularProgressIndicator()),
          ),
        ),

        // Reconnecting banner
        if (_isReconnecting)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Reconnecting...",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),

        // Memory usage
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              getMemoryInfo(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
