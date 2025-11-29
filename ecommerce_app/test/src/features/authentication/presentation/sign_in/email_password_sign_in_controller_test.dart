import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  final testEmail = 'test@test.com';
  final testPassword = 'password';
  group('EmailPasswordSignInController submit() method', () {
    test(
      ''' Given formType is singIn 
      When signInWithEmailAndPassword successes
      Then return true
      And state is AsyncData
      ''',
      () async {
        // Setup
        final authRepository = MockAuthRepository();
        when(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).thenAnswer((_) async => Future.value());

        final controller = EmailPasswordSignInController(
          authRepository: authRepository,
          formType: EmailPasswordSignInFormType.signIn,
        );

        // Expect Later
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading(),
              ),
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncData(null),
              ),
            ],
          ),
        );

        // Run
        final result = await controller.submit(testEmail, testPassword);

        // Verify
        verify(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).called(1);
        expect(result, true);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      ''' Given formType is singIn 
      When signInWithEmailAndPassword is failure
      Then return false
      And state is AsyncError
      ''',
      () async {
        // Setup
        final authRepository = MockAuthRepository();
        final exception = Exception('Connection failed');
        when(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).thenThrow(exception);

        final controller = EmailPasswordSignInController(
          authRepository: authRepository,
          formType: EmailPasswordSignInFormType.signIn,
        );

        // Expect Later
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading(),
              ),
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.signIn);
                expect(state.value, isA<AsyncError>());
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );

        // Run
        final result = await controller.submit(testEmail, testPassword);

        // Verify
        verify(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).called(1);
        expect(result, false);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
