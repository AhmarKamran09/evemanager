import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class UpdateInvitationDesignUsecase {
  final FirebaseRepository firebaseRepository;

  UpdateInvitationDesignUsecase({required this.firebaseRepository});

  Future<void> call(InvitationDesignEntity invitationDesignEntity) async {
    return await firebaseRepository.UpdateInvitationDesign(invitationDesignEntity);
  }

}
