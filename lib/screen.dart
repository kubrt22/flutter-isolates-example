import 'dart:math';

import 'package:flutter/material.dart';

import 'isolate.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String _returnedValue = 'nic';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runHardComputation() {
    final result = timeHardComputation().inMilliseconds;
    setState(() {
      _returnedValue = 'UI thread: $result ms';
    });
  }

  Future<void> _runIsolate() async {
    final result = await runWithIsolate();
    final resultMs = result.inMilliseconds;
    if (!mounted) return;

    setState(() {
      _returnedValue = 'Isolate: $resultMs ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final spin = _controller.value * 2 * pi;
                  return ClipRect(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(color: Colors.indigo),
                          child: const SizedBox.expand(),
                        ),
                        Transform.rotate(
                          angle: -spin,
                          child: SizedBox.square(
                            dimension: 150,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _runHardComputation,
                      child: const Text('UI Vlákno'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _runIsolate,
                      child: const Text('Isolate'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 22),
              child: Text(
                _returnedValue,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
