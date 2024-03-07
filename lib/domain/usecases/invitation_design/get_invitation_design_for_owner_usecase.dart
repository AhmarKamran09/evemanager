import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetInvitationDesignForOwnerUsecase {
  final FirebaseRepository firebaseRepository;

  GetInvitationDesignForOwnerUsecase({required this.firebaseRepository});

  Stream<List<InvitationDesignEntity>> call(String ownerid)  {
    return  firebaseRepository.GetInvitationDesignforOwner(ownerid);
  }
}
