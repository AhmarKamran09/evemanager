import 'dart:io';

import 'package:evemanager/constants.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';

abstract class FirebaseRepository {
// USER

  Future<bool> SignInUser(UserEntity user);
  Future<void> SignUpUser(UserEntity user);
  Future<void> SignOutUser();
  Future<bool> IsSignInUser();
  Future<void> UpdateUser(UserEntity user);
  Future<void> DeleteUser(String uid);
  Future<UserEntity> GetUser(String uid);
  Future<String?> GetCurrentUid();

  // Venues
  Future<void> AddVenue(VenueEntity venueEntity);
  Future<void> EditAvailabilityOfVenue(
      String hallid, Map<String, bool> availability);
  Future<void> DeleteVenue(String id);
  Future<void> UpdateVenue(VenueEntity venueEntity);
  Future<void> UpdateVenuePictures(
    String id,
    List<File>? images,
  );
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
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient();
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid);
  Future<void> UpdateEntertainment(EntertainmentEntity entertainmentEntity);

// Photography
  Future<void> AddPhotography(PhotographyEntity photographyEntity);
  Future<void> DeletePhotography(String id);
  Stream<List<PhotographyEntity>> GetPhotographyforClient();
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid);
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity);

// Sweets
  Future<void> AddSweets(SweetEntity sweetEntity);
  Future<void> DeleteSweets(String id);
  Stream<List<SweetEntity>> GetSweetsforClient();
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid);
  Future<void> UpdateSweets(SweetEntity sweetEntity);

// Videography
  Future<void> AddVideography(VideographyEntity videographyEntity);
  Future<void> DeleteVideography(String id);
  Stream<List<VideographyEntity>> GetVideographyforClient();
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid);
  Future<void> UpdateVideography(VideographyEntity videographyEntity);

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

  Future<void> AddRating(RatingEntity ratingEntity);
   Future<double> GetRating(String serviceId);

}
