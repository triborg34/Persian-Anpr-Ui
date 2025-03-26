import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/widgets/videogetter.dart';


class VideoStream extends StatefulWidget {
  final String url;
  const VideoStream({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  late WebSocket _socket;
  bool isConnected = false;
  bool _isReconnecting = false;

  StreamSubscription? _subscription;
  StreamSubscription? _reconnectSub;

  void connect() {
    _socket = WebSocket(widget.url);
    _socket.connect();

    _subscription = _socket.stream.listen((data) {
      setState(() {
        isConnected = true;
      });
    }, onDone: () {
      setState(() {
        isConnected = false;
      });
    }, onError: (e) {
      setState(() {
        isConnected = false;
      });
    });

    _reconnectSub = _socket.reconnectingStream.listen((reconnecting) {
      setState(() {
        _isReconnecting = reconnecting;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _reconnectSub?.cancel();
    _socket.disconnect();
    super.dispose();
  }

  @override
void didUpdateWidget(covariant VideoStream oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.url != widget.url) {
    _socket.disconnect(); // kills previous connection
    connect(); // starts new one
  }
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: purpule),
          ),
          padding: const EdgeInsets.all(8.0),
          height: 350,
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: StreamBuilder(
              stream: _socket.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Image.memory(
                  Uint8List.fromList(base64Decode(snapshot.data.toString())),
                  gaplessPlayback: true,
                  fit: BoxFit.fill,
                  excludeFromSemantics: true,
                );
              },
            ),
          ),
        ),
        if (_isReconnecting)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Reconnecting...",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
