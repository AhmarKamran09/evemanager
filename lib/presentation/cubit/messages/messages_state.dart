part of 'messages_cubit.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

final class MessagesSuccess extends MessagesState {
  final List<MessageEntity>? messageEntity;

  MessagesSuccess({this.messageEntity});
  @override
  List<Object> get props => [
        // messageEntity!,
      ];
}

final class MessagesLoading extends MessagesState {
  @override
  List<Object> get props => [];
}

final class MessagesFailure extends MessagesState {
  @override
  List<Object> get props => [];
}
