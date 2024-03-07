import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class AddInvitationDesignUsecase {
  final FirebaseRepository firebaseRepository;

  AddInvitationDesignUsecase({required this.firebaseRepository});

  Future<void> call(InvitationDesignEntity invitationDesignEntity) async {
    return await firebaseRepository.AddInvitationDesign(invitationDesignEntity);
  }
}
