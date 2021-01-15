import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttercommerce/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:fluttercommerce/Repository/repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(const CommentState());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is CommentChanged) {
      yield _mapCommentChangedToState(event, state);
    } else if (event is CommentSubmitted) {
      yield* _mapCommentSubmittedToState(event, state);
    }
  }

  CommentState _mapCommentChangedToState(
    CommentChanged event,
    CommentState state,
  ) {
    final comment = Address.dirty(event.comment);
    return state.copyWith(
      comment: comment,
      status: Formz.validate([comment]),
    );
  }

  Stream<CommentState> _mapCommentSubmittedToState(
    CommentSubmitted event,
    CommentState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final post =
            await ProductRepository().postComment(comment: state.comment.value);
        if (post == true) {
          // yield state.copyWith(status: FormzStatus.submissionInProgress);
          // await Future<void>.delayed(const Duration(seconds: 1));
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else
          yield state.copyWith(status: FormzStatus.submissionFailure);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
