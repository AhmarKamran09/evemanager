import 'dart:io';

import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
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

// Marriage Halls
  Future<void> AddMarriageHall(MarriageHallEntity marriageHallEntity);
  Future<void> DeleteMarriageHall(String id);
  Future<void> UpdateMarriageHall(MarriageHallEntity marriageHallEntity);
  Stream<List<MarriageHallEntity>> GetMarriageHallforClient();
  Stream<List<MarriageHallEntity>> GetMarriageHallforOwner(String ownerid);

  Future<void> EditAvailabilityOfHall(
      String hallid, Map<String, bool> availability);
  Future<void> UpdateMarriageHallPictures(
    String id,
    List<File>? images,
  );

// Catering Service
  Future<void> AddCateringService(CateringEntity cateringEntity);
  Future<void> DeleteCateringService(String id);
  Future<void> UpdateCateringService(CateringEntity cateringEntity);
  Stream<List<CateringEntity>> GetCateringServiceforClient();
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid);
}
