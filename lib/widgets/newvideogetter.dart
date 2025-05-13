import 'dart:async';


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

  StreamSubscription? _reconnectSub;

  bool _error = false;

bool _isReconnecting = false;

void _handleStreamError() {
  if (!mounted || _isReconnecting) return;

  _isReconnecting = true;

  setState(() {
    _error = true;
  });

  _reconnectSub = Stream.periodic(Duration(seconds: 5)).listen((_) async {
    final isAlive = await _checkFeed();
    if (isAlive && mounted) {
      _isReconnecting = false;
      setState(() {
        _error = false;
      });
      _reconnectSub?.cancel();
    }
  });
}

  void _handleStreamLoad() {
    if (_error) {
      setState(() {
        _error = false;
      });
    }
  }

  Future<bool> _checkFeed() async {
    try {
      final response = await html.HttpRequest.request(
        widget.url,
        method: 'HEAD',
      );
      return response.status == 200;
    } catch (_) {
      return false;
    }
  }


@override
void dispose()async {
  _reconnectSub?.cancel();
  _isReconnecting = false;

  super.dispose();
}

@override
void didUpdateWidget(VideoStream oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.url != widget.url) {


    _reconnectSub?.cancel();
    _reconnectSub = null;
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
              child:_error==false? CameraFeed(
                key: ValueKey(widget.url), // Force rebuild if URL changes
                streamUrl: widget.url,
                onError: _handleStreamError,
                onLoad: _handleStreamLoad,
              ): Center(child: Text("No Camera"),) ) ,
        ),

        // Reconnecting banner

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
