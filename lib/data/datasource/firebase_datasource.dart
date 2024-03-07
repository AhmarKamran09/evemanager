import 'dart:io';

import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';

abstract class FirebaseDatasource {
//  User
// Auth
  Future<String?> GetCurrentUid();
  Future<bool> SignInUser(UserEntity user);
  Future<void> SignUpUser(UserEntity user);
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

  Future<void> EditAvailabilityOfVenue(
      String hallid, Map<String, bool> availability);
  Future<void> UpdateVenuePictures(
    String id,
    List<File>? images,
  );

// Catering Service
  Future<void> AddCateringService(CateringEntity cateringEntity);
  Future<void> DeleteCateringService(String id);
  Future<void> UpdateCateringService(CateringEntity cateringEntity);
  Stream<List<CateringEntity>> GetCateringServiceforClient();
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid);

// Bridal Makeup and hair
  Future<void> AddBridalMakeupAndHair(BridalMakeupAndHairEntity bridalMakeupAndHairEntity);
  Future<void> DeleteBridalMakeupAndHair(String id);
  Stream<List<BridalMakeupAndHairEntity>> GetBridalMakeupAndHairforClient();
  Stream<List<BridalMakeupAndHairEntity>> GetBridalMakeupAndHairforOwner(String ownerid);
  Future<void> UpdateBridalMakeupAndHair(BridalMakeupAndHairEntity bridalMakeupAndHairEntity);
}
