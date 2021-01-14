import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:fluttercommerce/Repository/repository.dart';

part 'repass_event.dart';
part 'repass_state.dart';

class RepassBloc extends Bloc<RepassEvent, RepassState> {
  RepassBloc() : super(const RepassState());

  @override
  Stream<RepassState> mapEventToState(
    RepassEvent event,
  ) async* {
    if (event is RepassPasswordNowChanged) {
      yield _mapPasswordNowChangedToState(event, state);
    } else if (event is RepassPasswordNewChanged) {
      yield _mapPasswordNewChangedToState(event, state);
    } else if (event is RepassPasswordVerifyChanged) {
      yield _mapPasswordVerifyChangedToState(event, state);
    } else if (event is RepassSubmitted) {
      yield* _mapRepassSubmittedToState(event, state);
    }
  }

  RepassState _mapPasswordNowChangedToState(
    RepassPasswordNowChanged event,
    RepassState state,
  ) {
    final nowPassword = Password.dirty(event.password);
    return state.copyWith(
      nowPassword: nowPassword,
      status: Formz.validate([nowPassword]),
    );
  }

  RepassState _mapPasswordNewChangedToState(
    RepassPasswordNewChanged event,
    RepassState state,
  ) {
    final newPassword = Password.dirty(event.password);
    return state.copyWith(
      newPassword: newPassword,
      status: Formz.validate([newPassword]),
    );
  }

  RepassState _mapPasswordVerifyChangedToState(
    RepassPasswordVerifyChanged event,
    RepassState state,
  ) {
    final passwordVerify = ConfirmedPassword.dirty(
        password: state.newPassword.value, value: event.passwordVerify);
    return state.copyWith(
      passwordVerify: passwordVerify,
      status: Formz.validate([passwordVerify]),
    );
  }

  Stream<RepassState> _mapRepassSubmittedToState(
    RepassSubmitted event,
    RepassState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final post = await AccountRepository().rePass(
          oldPass: state.nowPassword.value,
          newPass: state.newPassword.value,
          rePass: state.passwordVerify.value,
        );
        if (post)
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        else
          yield state.copyWith(status: FormzStatus.submissionFailure);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
