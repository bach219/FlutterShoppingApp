part of 'comment_bloc.dart';

class CommentState extends Equatable {
  const CommentState({
    this.status = FormzStatus.pure,
    this.comment = const Address.pure(),
  });

  final FormzStatus status;
  final Address comment;

  CommentState copyWith({
    FormzStatus status,
    Address comment,
  }) {
    return CommentState(
      status: status ?? this.status,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object> get props => [status, comment];
}
