import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncLoading, AsyncData;
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;

import '../../data/fake_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  final FakeAuthRepository _authRepository;

  AccountScreenController({required FakeAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AsyncData(null));

  Future<void> signOut() async {
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

    state = const AsyncLoading();
    state = await AsyncValue.guard(_authRepository.signOut);
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue>(
        (ref) {
  final authRepository = ref.watch(fakeAuthRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
