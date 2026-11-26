import 'package:flutter_test/flutter_test.dart';
import 'package:src/models/player_profile_model.dart';

void main() {
<<<<<<< HEAD
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BallerDisciplineApp(hasSession: false));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
=======
  test('Smoke test kiểm tra khởi tạo và định dạng dữ liệu cầu thủ', () {
    const profile = PlayerProfileModel(
      id: 'smoke-test-uuid',
      fullName: 'Nguyễn Minh Đức',
      jerseyNumber: 10,
      position: 'Tiền đạo',
    );
    expect(profile.fullName, equals('Nguyễn Minh Đức'));
    expect(profile.jerseyNumber, equals(10));
    expect(profile.position, equals('Tiền đạo'));
>>>>>>> 0ce3c3b022a969bab777bc50bf57a16c68eff7ea
  });
}
