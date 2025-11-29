import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      // Setup
      final authRepository = MockAuthRepository();
      final controller =
          AccountScreenController(authRepository: authRepository);

      // Run & Verify
      verifyNever(authRepository.signOut);
      expect(controller.state, AsyncData<void>(null));
    });

    test('signOut success', () async {
      // Setup
      final authRepository = MockAuthRepository();
      when(authRepository.signOut).thenAnswer(
        (_) => Future.value(),
      );
      final controller =
          AccountScreenController(authRepository: authRepository);

      // Run
      await controller.signOut();

      // Verify
      verify(authRepository.signOut).called(1);
      expect(controller.state, const AsyncData<void>(null));
    });
  });
}
