import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/fake_auth_repository.dart';
import 'email_password_sign_in_state.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  final FakeAuthRepository _authRepository;

  EmailPasswordSignInController({
    required FakeAuthRepository authRepository,
    required EmailPasswordSignInFormType formType,
  })  : _authRepository = authRepository,
        super(EmailPasswordSignInState(formType: formType));

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _authenticate(email, password));
    state = state.copyWith(value: value);
    return !value.hasError;
  }
 
  Future<void> _authenticate(String email, String password) async {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return _authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return _authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

  void updateFormType(EmailPasswordSignInFormType formType) =>
      state = state.copyWith(formType: formType);
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>(
  (ref, formType) {
    final authRepository = ref.watch(fakeAuthRepositoryProvider);
    return EmailPasswordSignInController(
        authRepository: authRepository, formType: formType);
  },
);
