import 'package:cars_app/UI/views/home_screen/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('button ...', (tester) async {
    await tester.pumpWidget(HomeScreen());

    Finder buttonText = find.text('Carro');

    expect(buttonText, findsOneWidget);
  });
}
