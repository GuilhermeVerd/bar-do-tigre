import 'package:flutter_test/flutter_test.dart';
import 'package:bar_do_tigre/main.dart';

void main() {
  testWidgets('Aplicativo abre corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const BarDoTigreApp());

    expect(find.text('Identificação'), findsOneWidget);
    expect(find.text('Quem está registrando?'), findsOneWidget);
  });
}
