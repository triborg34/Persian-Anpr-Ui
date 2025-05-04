import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class MemoryGuard extends StatefulWidget {
  const MemoryGuard({super.key});

  @override
  State<MemoryGuard> createState() => _MemoryGuardState();
}

class _MemoryGuardState extends State<MemoryGuard> {
  Timer? _timer;
  double usedMb = 0;
  bool _warned = false;

  //  Updated thresholds for higher memory setup
  static const int warningThresholdMb = 1200; // Show toast at 1.2 GB
  static const int reloadThresholdMb = 1500;  // Reload at 1.5 GB
  static const int cooldownMinutes = 10;      // Don't reload more than once every 10 minutes

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      try {
        final mem = html.window.performance.memory!;
        final used = mem.usedJSHeapSize! / (1024 * 1024); // Convert to MB
        setState(() {
          usedMb = used;
        });

        //  Show one-time warning if above threshold
        if (used > warningThresholdMb && !_warned) {
          _warned = true;
          _showToast("Memory usage high. Reloading soon if it grows...");
        }

        //  Prevent infinite reloads using localStorage cooldown
        final lastReloadStr = html.window.localStorage['lastReload'];
        final now = DateTime.now().millisecondsSinceEpoch;
        final lastReload = int.tryParse(lastReloadStr ?? '0') ?? 0;
        final minutesSince = (now - lastReload) / (1000 * 60);

        if (used > reloadThresholdMb && minutesSince > cooldownMinutes) {
          html.window.localStorage['lastReload'] = now.toString();
          html.window.location.reload();
        }
      } catch (_) {}
    });
  }

  void _showToast(String msg) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              msg,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 4), () => entry.remove());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // No visible UI — background only
  }
}
