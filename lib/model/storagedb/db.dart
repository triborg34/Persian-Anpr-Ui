import 'dart:async';
import 'package:pocketbase/pocketbase.dart';
import 'package:unapwebv/model/model.dart';

class DatabaseHelper {
  final PocketBase pb = PocketBase('http://localhost:8090');
  final _entryStreamController = StreamController<List<plateModel>>.broadcast();

  Stream<List<plateModel>> get entryStream => _entryStreamController.stream;

  DatabaseHelper() {
    _fetchInitialData();
    _subscribeToRealtime();
  }

  // Fetch initial data
  Future<void> _fetchInitialData() async {
    try {
      final result = await pb.collection('database').getList();
      final List<plateModel> plates =
          result.items.map((item) => plateModel.fromJson(item.toJson())).toList();

      _entryStreamController.add(plates);
    } catch (e) {
      print('Error fetching initial data: $e');
    }
  }

  // Subscribe to real-time updates
  void _subscribeToRealtime() {
    pb.collection('database').subscribe('*', (e) {
      print('Realtime Event: ${e.action}');
      print('Updated Record: ${e.record}');

      _fetchInitialData(); // Re-fetch data when a record is created/updated/deleted
    });
  }

  // Unsubscribe from real-time updates
  void dispose() {
    pb.collection('database').unsubscribe('*');
    _entryStreamController.close();
  }
}
