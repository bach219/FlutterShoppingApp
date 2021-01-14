import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignUpPasswordVerifyChanged) {
      yield _mapPasswordVerifyChangedToState(event, state);
    } else if (event is SignUpAddressChanged) {
      yield _mapAddressChangedToState(event, state);
    } else if (event is SignUpPhoneChanged) {
      yield _mapPhoneChangedToState(event, state);
    } else if (event is SignUpSexChanged) {
      yield _mapSexChangedToState(event, state);
    } else if (event is SignUpNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapEmailChangedToState(
    SignUpEmailChanged event,
    SignUpState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  SignUpState _mapPasswordChangedToState(
    SignUpPasswordChanged event,
    SignUpState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
        state.address,
        state.name,
        state.passwordVerify,
        state.phone,
        state.sex
      ]),
    );
  }

  SignUpState _mapPasswordVerifyChangedToState(
    SignUpPasswordVerifyChanged event,
    SignUpState state,
  ) {
    final passwordVerify = ConfirmedPassword.dirty(
        password: state.password.value, value: event.passwordVerify);
    return state.copyWith(
      passwordVerify: passwordVerify,
      status: Formz.validate([
        passwordVerify,
        state.email,
        state.address,
        state.name,
        state.password,
        state.phone,
        state.sex
      ]),
    );
  }

  SignUpState _mapAddressChangedToState(
    SignUpAddressChanged event,
    SignUpState state,
  ) {
    final address = Address.dirty(event.address);
    return state.copyWith(
      address: address,
      status: Formz.validate([
        address,
        state.email,
        state.passwordVerify,
        state.name,
        state.password,
        state.phone,
        state.sex
      ]),
    );
  }

  SignUpState _mapPhoneChangedToState(
    SignUpPhoneChanged event,
    SignUpState state,
  ) {
    final phone = Phone.dirty(event.phone);
    return state.copyWith(
      phone: phone,
      status: Formz.validate([
        phone,
        state.email,
        state.passwordVerify,
        state.name,
        state.password,
        state.address,
        state.sex
      ]),
    );
  }

  SignUpState _mapNameChangedToState(
    SignUpNameChanged event,
    SignUpState state,
  ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.passwordVerify,
        state.phone,
        state.password,
        state.address,
        state.sex
      ]),
    );
  }

  SignUpState _mapSexChangedToState(
    SignUpSexChanged event,
    SignUpState state,
  ) {
    final sex = Sex.dirty(event.sex);
    return state.copyWith(
      sex: sex,
      status: Formz.validate([
        sex,
        state.email,
        state.passwordVerify,
        state.phone,
        state.password,
        state.address,
        state.name
      ]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
    SignUpSubmitted event,
    SignUpState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
          passwordVerify: state.passwordVerify.value,
          address: state.address.value,
          phone: state.phone.value,
          sex: state.sex.value,
          name: state.name.value,
        );

        
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
