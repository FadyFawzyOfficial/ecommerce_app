import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;

  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });

  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      // Run & Verify
      verifyNever(authRepository.signOut);
      expect(controller.state, AsyncData<void>(null));
    });

    test(
      'signOut success',
      () async {
        when(authRepository.signOut).thenAnswer(
          (_) => Future.value(),
        );

        // Expect Later
        expectLater(
          controller.stream,
          emitsInOrder(const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]),
        );

        // Run
        await controller.signOut();

        // Verify
        verify(authRepository.signOut).called(1);
        // expect(controller.state, const AsyncData<void>(null));
      },
      //! A shorter test timeout guarantees that when our test hang, they fail quickly.
      //! This can save us a lot of time & money specially when running
      //! hundreds/thousands of tests on CI can be expensive, so we want them to
      //! fast even when they fail.
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      'signOut failure',
      () async {
        // Setup
        final exception = Exception('Connection failed');
        when(authRepository.signOut).thenThrow(exception);

        // Expect Later
        expectLater(
          controller.stream,
          emitsInOrder([
            AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ]),
        );

        // Run
        await controller.signOut();

        // Verify
        verify(authRepository.signOut).called(1);
        // expect(controller.state.hasError, true);
        // expect(controller.state, isA<AsyncError>());
      },
      //! A shorter test timeout guarantees that when our test hang, they fail quickly.
      //! This can save us a lot of time & money specially when running
      //! hundreds/thousands of tests on CI can be expensive, so we want them to
      //! fast even when they fail.
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
