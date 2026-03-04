import 'dart:async';

import 'package:flutter/foundation.dart';

class HomeLogic extends ChangeNotifier {
  String greeting = '';
  String currentTime = '';
  String currentDate = '';
  bool hasAbsentedToday = false;

  Timer? _timer;

  void start() {
    _updateNow();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateNow();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateNow() {
    final now = DateTime.now();

    currentTime =
        '${_formatTime(now.hour)}:${_formatTime(now.minute)}:${_formatTime(now.second)}';
    currentDate = '${now.day} ${_getMonthName(now.month)} ${now.year}';
    greeting = _buildGreeting(now.hour);

    notifyListeners();
  }

  String _buildGreeting(int hour) {
    if (hour < 12) {
      return 'Good Morning,';
    }
    if (hour < 17) {
      return 'Good Afternoon,';
    }
    if (hour < 21) {
      return 'Good Evening,';
    }
    return 'Good Night,';
  }

  String _formatTime(int value) {
    return value.toString().padLeft(2, '0');
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
