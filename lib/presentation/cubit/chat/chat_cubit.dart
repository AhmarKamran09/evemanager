import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/usecases/message/get_chats_for_admin_usecase.dart';
import 'package:evemanager/domain/usecases/message/get_chats_for_client_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetChatsForClientUsecase getChatsForClientUsecase;
  final GetChatsForAdminUsecase getChatsForAdminUsecase;
  ChatCubit({
    required this.getChatsForAdminUsecase,
    required this.getChatsForClientUsecase,
  }) : super(ChatInitial());

  Future<void> GetChatsForClient({required String userid}) async {
    try {
      emit(ChatLoading());
      final streamResponse = await getChatsForClientUsecase.call(userid);
      streamResponse.listen((chatEntity) {
        emit(ChatSuccess(chatEntity: chatEntity));
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }

  Future<void> GetChatsForAdmin({required String userid}) async {
    try {
      emit(ChatLoading());
      final streamResponse = await getChatsForAdminUsecase.call(userid);
      streamResponse.listen((chatEntity) {
        emit(ChatSuccess(chatEntity: chatEntity));
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }
}
