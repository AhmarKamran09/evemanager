part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  final  List<ChatEntity> chatEntity;

  ChatSuccess({required this.chatEntity});
  @override
  List<Object> get props => [
        chatEntity,
      ];
}

final class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

final class ChatFailure extends ChatState {
  @override
  List<Object> get props => [];
}
