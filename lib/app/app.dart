import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bounded_contexts/journal/presentation/home_page.dart';

/// Корневая оболочка приложения.
class BeerLoggerApp extends StatelessWidget {
  const BeerLoggerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(title: 'Пивомер', home: HomePage()),
    );
  }
}
