import 'dart:async';

import 'package:unapwebv/model/consts.dart';
import 'package:unapwebv/model/model.dart';

class DatabaseHelper {
  // final PocketBase pb = PocketBase('http://localhost:8090');
  final _entryStreamController = StreamController<List<plateModel>>.broadcast();
  List<plateModel> _currentPlates = []; // Store current records

  Stream<List<plateModel>> get entryStream => _entryStreamController.stream;

  DatabaseHelper() {
    _fetchInitialData();
    _subscribeToRealtime();
  }

  // Fetch initial data once
  Future<void> _fetchInitialData() async {
    try {
      final result = await pb.collection('database').getFullList(batch: 100,);
      _currentPlates =
          result.map((item) => plateModel.fromJson(item.toJson())).toList();
      _entryStreamController.add(_currentPlates);
    } catch (e) {

    }
  }

  // Subscribe to real-time updates without re-fetching everything
  void _subscribeToRealtime() {
    pb.collection('database').subscribe('*', (e) {


      if (e.action == "create") {
        // Add new record
        _currentPlates.add(plateModel.fromJson(e.record!.toJson()));
      } else if (e.action == "update") {
        // Find and update the existing record
        int index =
            _currentPlates.indexWhere((plate) => plate.id == e.record!.id);
        if (index != -1) {
          _currentPlates[index] = plateModel.fromJson(e.record!.toJson());
        }
      } else if (e.action == "delete") {
        // Remove the deleted record
        _currentPlates.removeWhere((plate) => plate.id == e.record!.id);
      }

      // Update the stream with new data
      _entryStreamController.add(List.from(_currentPlates));
    });
  }

  // Unsubscribe from real-time updates
  void dispose() {
    pb.collection('database').unsubscribe('*');
    _entryStreamController.close();
  }
}
