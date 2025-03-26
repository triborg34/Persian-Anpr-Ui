import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket {
  late String url;
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  bool _isConnecting = false;
  bool _shouldReconnect = true; // New flag

  final StreamController<dynamic> _streamController = StreamController.broadcast();
  final StreamController<bool> _reconnectingController = StreamController.broadcast();

  Stream<dynamic> get stream => _streamController.stream;
  Stream<bool> get reconnectingStream => _reconnectingController.stream;

  WebSocket(this.url);

  void connect() {
    if (_isConnecting || !_shouldReconnect) return;
    _isConnecting = true;

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _channel!.stream.listen(
        (data) {
          if (!_streamController.isClosed) {
            _streamController.add(data);
          }
        },
        onDone: () {
          _isConnecting = false;

          // Don't reconnect if server closed with error (invalid path)
          if (_shouldReconnect && _channel != null) {
            _tryReconnect();
          }
        },
        onError: (error) {
          _isConnecting = false;
          if (_shouldReconnect) {
            _tryReconnect();
          }
        },
        cancelOnError: true,
      );

      if (!_reconnectingController.isClosed) {
        _reconnectingController.add(false);
      }
    } catch (e) {
      _isConnecting = false;
      _tryReconnect();
    }
  }

  void _tryReconnect() {
    if (_reconnectTimer != null && _reconnectTimer!.isActive) return;

    if (!_reconnectingController.isClosed) {
      _reconnectingController.add(true);
    }

    _reconnectTimer = Timer(Duration(seconds: 3), () {
      connect();
    });
  }

  void disconnect() {
    _shouldReconnect = false; // <- this stops any future reconnects
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    if (!_streamController.isClosed) {
      _streamController.close();
    }
    if (!_reconnectingController.isClosed) {
      _reconnectingController.close();
    }
  }
}
