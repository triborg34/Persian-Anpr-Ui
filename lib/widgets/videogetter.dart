import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statuses;

class WebSocket {
  late String url;
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isConnecting = false;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 10;
  final int _initialReconnectDelay = 1; // seconds
  final int _maxReconnectDelay = 30; // seconds

  final StreamController<dynamic> _streamController = StreamController.broadcast();
  final StreamController<bool> _reconnectingController = StreamController.broadcast();
  final StreamController<ConnectionStatus> _connectionStatusController = StreamController.broadcast();

  Stream<dynamic> get stream => _streamController.stream;
  Stream<bool> get reconnectingStream => _reconnectingController.stream;
  Stream<ConnectionStatus> get connectionStatusStream => _connectionStatusController.stream;

  // Connection status
  ConnectionStatus _status = ConnectionStatus.disconnected;
  ConnectionStatus get status => _status;

  WebSocket(this.url);

  void connect() {
    if (_isConnecting || !_shouldReconnect) return;
    _isConnecting = true;
    _updateStatus(ConnectionStatus.connecting);

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));

      // Start ping timer for heartbeat
      _startPingTimer();

      _channel!.stream.listen(
        (data) {
          if (!_streamController.isClosed) {
            _streamController.add(data);
          }
          // Reset reconnect attempts on successful data
          _reconnectAttempts = 0;
          _updateStatus(ConnectionStatus.connected);
        },
        onDone: () {
          _isConnecting = false;
          _updateStatus(ConnectionStatus.disconnected);

          // Don't reconnect if server closed with error (invalid path)
          if (_shouldReconnect) {
            _tryReconnect();
          }
        },
        onError: (error) {
          print("WebSocket Error: $error");
          _isConnecting = false;
          _updateStatus(ConnectionStatus.error);
          if (_shouldReconnect) {
            _tryReconnect();
          }
        },
        cancelOnError: false, // Changed to false to handle errors properly
      );

      if (!_reconnectingController.isClosed) {
        _reconnectingController.add(false);
      }
    } catch (e) {
      print("WebSocket Connection Error: $e");
      _isConnecting = false;
      _updateStatus(ConnectionStatus.error);
      _tryReconnect();
    }
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(seconds: 20), (_) {
      try {
        // Send a ping message to keep the connection alive
        if (_channel != null && _status == ConnectionStatus.connected) {
          _channel!.sink.add('ping');
        }
      } catch (e) {
        print("Error sending ping: $e");
      }
    });
  }

  void _tryReconnect() {
    if (_reconnectTimer != null && _reconnectTimer!.isActive) return;
    
    _reconnectAttempts++;
    
    // Check if we've reached max attempts
    if (_reconnectAttempts > _maxReconnectAttempts) {
      _updateStatus(ConnectionStatus.failedPermanently);
      return; // Don't reconnect anymore
    }

    if (!_reconnectingController.isClosed) {
      _reconnectingController.add(true);
    }
    
    // Exponential backoff with jitter
    final backoff = _initialReconnectDelay * 
        (1 << (_reconnectAttempts > 5 ? 5 : _reconnectAttempts)); // Cap at 2^5
    final delay = (backoff + (DateTime.now().millisecondsSinceEpoch % 1000) / 1000)
        .clamp(1, _maxReconnectDelay);
    
    print("Reconnecting in $delay seconds (attempt $_reconnectAttempts)");
    
    _reconnectTimer = Timer(Duration(seconds: delay.toInt()), () {
      connect();
    });
  }

  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    
    try {
      _channel?.sink.close(statuses.normalClosure);
    } catch (e) {
      print("Error closing channel: $e");
    }
    
    _updateStatus(ConnectionStatus.disconnected);
    
    // Close stream controllers only when actually disposing the object
    // This allows reconnecting with the same WebSocket instance
  }
  
  void dispose() {
    disconnect();
    
    if (!_streamController.isClosed) {
      _streamController.close();
    }
    
    if (!_reconnectingController.isClosed) {
      _reconnectingController.close();
    }
    
    if (!_connectionStatusController.isClosed) {
      _connectionStatusController.close();
    }
  }
  
  void _updateStatus(ConnectionStatus newStatus) {
    _status = newStatus;
    if (!_connectionStatusController.isClosed) {
      _connectionStatusController.add(newStatus);
    }
  }
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
  failedPermanently
}