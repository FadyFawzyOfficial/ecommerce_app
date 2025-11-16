import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/app_user.dart';

class FakeAuthRepository {
  AppUser? get currentAppUser =>
      null; // ToDo: Update this to return the current user

  Stream<AppUser?> get authStateChanges =>
      Stream.value(null); // ToDo: Update this to return the auth state changes

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // ToDo: Implement this method
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    // ToDo: Implement this method
  }

  Future<void> signOut() async {
    // ToDo: Implement this method
  }
}

final fakeAuthRepositoryProvider =
    Provider<FakeAuthRepository>((ref) => FakeAuthRepository());

final authStateChangesStreamProvider = StreamProvider.autoDispose<AppUser?>(
    (ref) => ref.watch(fakeAuthRepositoryProvider).authStateChanges);
