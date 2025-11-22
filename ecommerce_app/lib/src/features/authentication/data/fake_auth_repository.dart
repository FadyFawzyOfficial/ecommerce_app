import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/in_memory_store.dart';
import '../domain/app_user.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  AppUser? get currentUser => _authState.value;

  Stream<AppUser?> get authStateChanges => _authState.stream;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) _authenticateUser(email);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) _authenticateUser(email);
  }

  Future<void> signOut() async {
    // await Future.delayed(const Duration(seconds: 3));
    // throw Exception('User not authenticated');
    _authState.value = null;
  }

  void _authenticateUser(String email) => _authState.value =
      AppUser(uid: email.split('').reversed.join(''), email: email);

  void dispose() => _authState.dispose();
}

final fakeAuthRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final authRepository = FakeAuthRepository();
  ref.onDispose(authRepository.dispose);
  return authRepository;
});

final authStateChangesStreamProvider = StreamProvider.autoDispose<AppUser?>(
    (ref) => ref.watch(fakeAuthRepositoryProvider).authStateChanges);
