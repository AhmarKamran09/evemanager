import 'dart:io';

import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';

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
}
