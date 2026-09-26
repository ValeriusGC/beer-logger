import 'package:flutter/material.dart';

import '../bounded_contexts/journal/presentation/home_page.dart';

/// Корневая оболочка приложения.
class BeerLoggerApp extends StatelessWidget {
  const BeerLoggerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Пивомер', home: HomePage());
  }
}
