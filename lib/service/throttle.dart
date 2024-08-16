import 'dart:async';
import 'dart:ui';

class Throttle {
  final Duration delay;
  Timer? _timer;

  Throttle(this.delay);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
