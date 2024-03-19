import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/usecases/message/get_chats_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetChatsUsecase getChatsUsecase;
  ChatCubit({
    required this.getChatsUsecase,
  }) : super(ChatInitial());

  Future<void> GetChats({required String userid}) async {
    try {
      emit(ChatLoading());
      final streamResponse = await getChatsUsecase.call(userid);
      streamResponse.listen(( chatEntity) {
        emit(ChatSuccess(chatEntity: chatEntity));
      });
      // emit(ChatSuccess(chatEntity: chatEntity));
    } catch (e) {
      emit(ChatFailure());
    }
  }
}
