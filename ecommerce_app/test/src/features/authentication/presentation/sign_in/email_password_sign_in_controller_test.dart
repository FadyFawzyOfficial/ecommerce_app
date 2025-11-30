@Timeout(Duration(milliseconds: 500))
library;

import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  final testEmail = 'test@test.com';
  final testPassword = 'password';
  group('EmailPasswordSignInController submit() method', () {
    test(''' Given formType is singIn 
      When signInWithEmailAndPassword successes
      Then return true
      And state is AsyncData
      ''', () async {
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
    });

    test(''' Given formType is singIn 
      When signInWithEmailAndPassword fails
      Then return false
      And state is AsyncError
      ''', () async {
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
    });

    test(''' Given formType is register 
      When createUserWithEmailAndPassword successes
      Then return true
      And state is AsyncData
      ''', () async {
      // Setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).thenAnswer((_) async => Future.value());

      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.register,
      );

      // Expect Later
      expectLater(
        controller.stream,
        emitsInOrder(
          [
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncLoading(),
            ),
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncData(null),
            ),
          ],
        ),
      );

      // Run
      final result = await controller.submit(testEmail, testPassword);

      // Verify
      verify(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).called(1);
      expect(result, true);
    });

    test(''' Given formType is register 
      When createUserWithEmailAndPassword fails
      Then return false
      And state is AsyncError
      ''', () async {
      // Setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Connection failed');
      when(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).thenThrow(exception);

      final controller = EmailPasswordSignInController(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.register,
      );

      // Expect Later
      expectLater(
        controller.stream,
        emitsInOrder(
          [
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncLoading(),
            ),
            predicate<EmailPasswordSignInState>((state) {
              expect(state.formType, EmailPasswordSignInFormType.register);
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
      verify(() => authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword)).called(1);
      expect(result, false);
    });
  });

  group('EmailPasswordSignInController updateFormType() method', () {
    test(''' Given formType is signIn 
      When updateFormType to register
      Then formType is register
      ''', () {
      // Setup
      final controller = EmailPasswordSignInController(
        authRepository: MockAuthRepository(),
        formType: EmailPasswordSignInFormType.signIn,
      );

      // Run
      controller.updateFormType(EmailPasswordSignInFormType.register);

      // Verify
      expect(
        controller.state,
        EmailPasswordSignInState(
          formType: EmailPasswordSignInFormType.register,
          value: const AsyncData(null),
        ),
      );
    });

    test(''' Given formType is register 
      When updateFormType to signIn
      Then formType is signIn
      ''', () {
      // Setup
      final controller = EmailPasswordSignInController(
        authRepository: MockAuthRepository(),
        formType: EmailPasswordSignInFormType.register,
      );

      // Run
      controller.updateFormType(EmailPasswordSignInFormType.signIn);

      // Verify
      expect(
        controller.state,
        EmailPasswordSignInState(
          formType: EmailPasswordSignInFormType.signIn,
          value: const AsyncData(null),
        ),
      );
    });
  });
}
