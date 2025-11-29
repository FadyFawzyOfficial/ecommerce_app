import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = 'password';
  final testUser =
      AppUser(uid: testEmail.split('').reversed.join(''), email: testEmail);

  FakeAuthRepository buildFakeAuthRepository() =>
      FakeAuthRepository(addDelay: false);

  group('FakeAuthRepository', () {
    test('currentUser is null', () {
      final fakeAuthRepository = buildFakeAuthRepository();
      expect(fakeAuthRepository.currentUser, null);
      expect(fakeAuthRepository.authStateChanges, emits(null));
    });

    test('currentUser is not null after user is signed in', () async {
      final fakeAuthRepository = buildFakeAuthRepository();
      await fakeAuthRepository.signInWithEmailAndPassword(
          testEmail, testPassword);
      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges, emits(testUser));
    });

    test('currentUser is not null after user registration', () async {
      final fakeAuthRepository = buildFakeAuthRepository();
      await fakeAuthRepository.createUserWithEmailAndPassword(
          testEmail, testPassword);
      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges, emits(testUser));
    });

    test('currentUser is null after user is signed out', () async {
      final fakeAuthRepository = buildFakeAuthRepository();
      await fakeAuthRepository.signInWithEmailAndPassword(
          testEmail, testPassword);
      // expect(
      //     fakeAuthRepository.authStateChanges,
      //     emitsInOrder([
      //       testUser, //  after sign in
      //       null, // after sign out
      //     ]));
      expect(fakeAuthRepository.currentUser, testUser);
      expect(fakeAuthRepository.authStateChanges, emits(testUser));
      await fakeAuthRepository.signOut();
      expect(fakeAuthRepository.currentUser, null);
      expect(fakeAuthRepository.authStateChanges, emits(null));
    });

    test('sign in after dispose throws an exception', () {
      final fakeAuthRepository = buildFakeAuthRepository();
      fakeAuthRepository.dispose();
      expect(
        () => fakeAuthRepository.signInWithEmailAndPassword(
            testEmail, testPassword),
        throwsStateError,
      );
    });
  });
}
