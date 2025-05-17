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
  bool _error = false;
  Timer? memoryMonitorTimer;
  String memoryInfo = "Memory: N/A";

   void initState() {
    super.initState();
    
    // Start memory monitoring at regular intervals
    memoryMonitorTimer = Timer.periodic(Duration(seconds: 5), (_) {
      if (mounted) {
        setState(() {
          memoryInfo = getMemoryInfo();
        });
      }
    });
  }

    void _handleStreamError() {
    if (!mounted) return;

    setState(() {
      _error = true;
    });

    // Attempt to reconnect every 5 seconds
  }

 void _handleStreamLoad() {
    if (_error && mounted) {
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
  void dispose()async {

    memoryMonitorTimer?.cancel();

    // var response=Dio().get('http://127.0.0.1:5000/video_release').then((value) => print(value),);
    super.dispose();
  }

   @override
  void didUpdateWidget(VideoStream oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      
      // Force error check on URL change
      _checkFeed().then((isAlive) {
        if (mounted) {
          setState(() {
            _error = !isAlive;
          });
        }
      });
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
              child: _error == false
                  ? CameraFeed(
                      key: ValueKey(widget.url), // Force rebuild if URL changes
                      streamUrl: widget.url,
                      onError: _handleStreamError,
                      onLoad: _handleStreamLoad ,
                      

                    )
                  : Center(
                      child: Text("No Camera"),
                    )),
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
