import 'package:flutter/material.dart';

/// Заглушка главного экрана — каркас архитектуры без домена.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Пивомер')),
      body: const Center(
        child: Text(
          'Каркас приложения. Домен и данные появятся на следующих шагах.',
        ),
      ),
    );
  }
}
