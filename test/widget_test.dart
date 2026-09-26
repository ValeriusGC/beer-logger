import 'package:beer_logger/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('на экране отображается заголовок Пивомер', (tester) async {
    await tester.pumpWidget(const BeerLoggerApp());

    expect(find.text('Пивомер'), findsOneWidget);
  });
}
