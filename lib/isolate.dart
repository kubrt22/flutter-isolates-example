import 'dart:isolate';

int hardComputation({int iterations = 1000000000}) {
  int sum = 0;
  for (int i = 0; i < iterations; i++) {
    sum += i;
  }
  assert(sum >= 0);
  return sum;
}

Duration timeHardComputation({int iterations = 1000000000}) {
  final stopwatch = Stopwatch()..start();

  hardComputation(iterations: iterations);

  stopwatch.stop();
  return stopwatch.elapsed;
}

Future<Duration> runWithIsolate({int iterations = 1000000000}) async {
  return await Isolate.run(() {
    return timeHardComputation(iterations: iterations);
  });
}
