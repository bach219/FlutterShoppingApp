part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentChanged extends CommentEvent {
  const CommentChanged(this.comment);

  final String comment;

  @override
  List<Object> get props => [comment];
}

class CommentSubmitted extends CommentEvent {
  const CommentSubmitted();
}
