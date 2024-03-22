import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/usecases/message/get_messages_usecase.dart';
import 'package:evemanager/domain/usecases/message/send_message_usecase.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit({
    required this.sendMessageUsecase,
    required this.getMessagesUsecase,
  }) : super(MessagesInitial());
  final SendMessageUsecase sendMessageUsecase;
  final GetMessagesUsecase getMessagesUsecase;

  Future<void> GetMessages(
      {required ChatEntity chatEntity, required UserRole userRole}) async {
    try {
      emit(MessagesLoading());
      final streamResponse = await getMessagesUsecase.call(
          chatEntity: chatEntity, userRole: userRole);
      streamResponse.listen((messageEntity) {
        emit(MessagesSuccess(messageEntity: messageEntity));
      });
      // emit(MessagesSuccess(messageEntity: chatresponse));
    } catch (e) {
      emit(MessagesFailure());
    }
  }

  Future<void> SendMessages(
      {required MessageEntity messageEntity,
      required UserRole userRole,
      required ChatEntity chatEntity,
      required String clientid,
      required ServiceEntity serviceEntity}) async {
    try {
      emit(MessagesLoading());
      await sendMessageUsecase.call(
          clientid: clientid,
          messageEntity: messageEntity,
          serviceEntity: serviceEntity);
      // streamResponse.listen(( chatEntity) {
      //   emit(ChatSuccess(chatEntity: chatEntity));
      // });
      await GetMessages(chatEntity: chatEntity, userRole: userRole);

      // emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailure());
    }
  }
}
