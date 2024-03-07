import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';

class GetInvitationDesignForClientUsecase {
  final FirebaseRepository firebaseRepository;

  GetInvitationDesignForClientUsecase({required this.firebaseRepository});

  Stream<List<InvitationDesignEntity>> call()  {
    return  firebaseRepository.GetInvitationDesignforClient();
  }
}