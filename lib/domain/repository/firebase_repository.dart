import 'dart:io';

import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
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

  // Marriage Halls
  Future<void> AddMarriageHall(MarriageHallEntity marriageHallEntity);
  Future<void> EditAvailabilityOfHall(
      String hallid, Map<String, bool> availability);
  Future<void> DeleteMarriageHall(String id);
  Future<void> UpdateMarriageHall(MarriageHallEntity marriageHallEntity);
  Future<void> UpdateMarriageHallPictures(
    String id,
    List<File>? images,
  );
  Stream<List<MarriageHallEntity>> GetMarriageHallforClient();
  Stream<List<MarriageHallEntity>> GetMarriageHallforOwner(String ownerid);

// Catering Service
  Future<void> AddCateringService(CateringEntity cateringEntity);
  Future<void> DeleteCateringService(String id);
  Future<void> UpdateCateringService(CateringEntity cateringEntity);
  Stream<List<CateringEntity>> GetCateringServiceforClient();
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid);
}
