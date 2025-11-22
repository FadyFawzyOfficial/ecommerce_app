import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;

import '../../data/fake_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue> {
  final FakeAuthRepository _authRepository;

  AccountScreenController({required FakeAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AsyncValue.data(null));

  Future<bool> signOut() async {
    //   try {
    //     state = const AsyncValue.loading();
    //     await _authRepository.signOut();
    //     state = const AsyncValue.data(null);
    //     return true;
    //   } catch (e, st) {
    //     state = AsyncValue.error(e, st);
    //     return false;
    //   }
    // }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_authRepository.signOut);
    return !state.hasError;
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue>(
        (ref) {
  final authRepository = ref.watch(fakeAuthRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
