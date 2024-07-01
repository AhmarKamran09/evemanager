import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';

abstract class FirebaseDatasource {
//  User
// Auth
  Future<String?> GetCurrentUid();
  Future<bool> SignInUser(UserEntity user);
  Future<void> SignUpUser(UserEntity user);
  Future<void> ResetPassword(UserEntity user);
  Future<void> SignOutUser();
  Future<bool> IsSignInUser();

  // User
  // CRUD
  Future<UserEntity> GetUser(String uid);
  Future<void> UpdateUser(UserEntity user);
  Future<void> DeleteUser(String uid);

// Venues
  Future<void> AddVenue(VenueEntity venueEntity);
  Future<void> DeleteVenue(String id);
  Future<void> UpdateVenue(VenueEntity venueEntity);
  Stream<List<VenueEntity>> GetVenueforClient();
  Stream<List<VenueEntity>> GetVenueforOwner(String ownerid);

// Catering Service
  Future<void> AddCateringService(CateringEntity cateringEntity);
  Future<void> DeleteCateringService(String id);
  Future<void> UpdateCateringService(CateringEntity cateringEntity);
  Stream<List<CateringEntity>> GetCateringServiceforClient();
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid);

// Decorations
  Future<void> AddDecorations(DecorationsEntity decorationsEntity);
  Future<void> DeleteDecorations(String id);
  Stream<List<DecorationsEntity>> GetDecorationsforClient();
  Stream<List<DecorationsEntity>> GetDecorationsforOwner(String ownerid);
  Future<void> UpdateDecorations(DecorationsEntity decorationsEntity);

  // Entertainment
  Future<void> AddEntertainment(EntertainmentEntity entertainmentEntity);
  Future<void> DeleteEntertainment(String id);
  Future<void> UpdateEntertainment(EntertainmentEntity entertainmentEntity);
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient();
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid);

// Photography
  Future<void> AddPhotography(PhotographyEntity photographyEntity);
  Future<void> DeletePhotography(String id);
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity);
  Stream<List<PhotographyEntity>> GetPhotographyforClient();
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid);

  // Sweet
  Future<void> AddSweets(SweetEntity sweetEntity);
  Future<void> DeleteSweets(String id);
  Future<void> UpdateSweets(SweetEntity sweetEntity);
  Stream<List<SweetEntity>> GetSweetsforClient();
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid);

// Videography
  Future<void> AddVideography(VideographyEntity videographyEntity);
  Future<void> DeleteVideography(String id);
  Future<void> UpdateVideography(VideographyEntity videographyEntity);
  Stream<List<VideographyEntity>> GetVideographyforClient();
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid);

  // Messages
  Future<void> SendMessage(
      {required MessageEntity messageEntity,
      required String clientid,
      required ServiceEntity serviceEntity});
  Stream<List<MessageEntity>> GetMessages({
    required ChatEntity chatEntity,
    required UserRole userRole,
    required String request_sender_id,
  });

  Stream<List<ChatEntity>> GetChatsForClient(String userid);
  Stream<List<ChatEntity>> GetChatsForAdmin(String userid);

// Rating
Future<void> AddRating({required double rating,required String serviceId,required Firebase_enum firebase_enum});

}
