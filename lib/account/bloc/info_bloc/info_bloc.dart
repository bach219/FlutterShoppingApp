import 'dart:async';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:core';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:fluttercommerce/Repository/repository.dart';
import 'package:fluttercommerce/models/models.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(const InfoState());

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    if (event is InfoStarted) {
      yield* _mapInfoStartedToState(event, state);
    } else if (event is InfoEmailChanged) {
      yield* _mapEmailChangedToState(event, state);
    } else if (event is InfoAddressChanged) {
      yield* _mapAddressChangedToState(event, state);
    } else if (event is InfoPhoneChanged) {
      yield* _mapPhoneChangedToState(event, state);
    } else if (event is InfoSexChanged) {
      yield* _mapSexChangedToState(event, state);
    } else if (event is InfoNameChanged) {
      yield* _mapNameChangedToState(event, state);
    } else if (event is InfoSubmitted) {
      yield* _mapInfoSubmittedToState(event, state);
    }
  }

  Stream<InfoState> _mapEmailChangedToState(
    InfoEmailChanged event,
    InfoState state,
  ) async* {
    final email = Email.dirty(event.email);
    yield state.copyWith(
      email: email,
      status: Formz.validate(
          [email, state.address, state.name, state.phone, state.sex]),
    );
  }

  Stream<InfoState> _mapAddressChangedToState(
    InfoAddressChanged event,
    InfoState state,
  ) async* {
    final address = Address.dirty(event.address);
    yield state.copyWith(
      address: address,
      status: Formz.validate([
        address,
        state.email,
        state.name,
        state.phone,
        state.sex,
      ]),
    );
  }

  Stream<InfoState> _mapPhoneChangedToState(
    InfoPhoneChanged event,
    InfoState state,
  ) async* {
    final phone = Phone.dirty(event.phone);
    yield state.copyWith(
      phone: phone,
      status: Formz.validate([
        phone,
        state.email,
        state.name,
        state.address,
        state.sex,
      ]),
    );
  }

  Stream<InfoState> _mapNameChangedToState(
    InfoNameChanged event,
    InfoState state,
  ) async* {
    final name = Name.dirty(event.name);
    yield state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.address,
        state.phone,
        state.sex,
      ]),
    );
  }

  Stream<InfoState> _mapSexChangedToState(
    InfoSexChanged event,
    InfoState state,
  ) async* {
    final sex = Sex.dirty(event.sex);
    yield state.copyWith(
      sex: sex,
      status: Formz.validate([
        sex,
        state.email,
        state.name,
        state.phone,
        state.address,
      ]),
    );
  }

  Stream<InfoState> _mapInfoSubmittedToState(
    InfoSubmitted event,
    InfoState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final post = await AccountRepository().postClient(
          email: state.email.value,
          address: state.address.value,
          phone: state.phone.value,
          sex: state.sex.value,
          name: state.name.value,
        );
        if (post) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<InfoState> _mapInfoStartedToState(
      InfoStarted event, InfoState state) async* {
    try {
      // await Future<void>.delayed(const Duration(seconds: 1));
      User c = await UserRepository().getUser();
      final sex = Sex.dirty(c.sex);
      final name = Name.dirty(c.name);
      final phone = Phone.dirty(c.phone);
      final address = Address.dirty(c.address);
      final email = Email.dirty(c.email);
      // yield state.copyWith(
      //   client: await UserRepository().getUser(),
      //   status: FormzStatus.submissionSuccess,
      //   // email: Email.pure(c.email),
      //   // name: Name.pure(c.name),
      //   // address: Address.pure(c.address),
      //   // phone: Phone.pure(c.phone),
      //   // sex: Sex.pure(c.sex),
      // );
      yield state.copyWith(
        sex: sex,
        name: name,
        phone: phone,
        address: address,
        email: email,
        status: Formz.validate([
          sex,
          email,
          name,
          phone,
          address,
        ]),
      );
      print("ahiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    } catch (_) {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
