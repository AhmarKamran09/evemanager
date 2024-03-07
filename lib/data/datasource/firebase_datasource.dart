import 'dart:io';

import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';

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

// Clothing
  Future<void> AddClothing(ClothingEntity clothingEntity) ;
  Future<void> DeleteClothing(String id) ;
  Future<void> UpdateClothing(ClothingEntity clothingEntity) ;
  Stream<List<ClothingEntity>> GetClothingforClient() ;
  Stream<List<ClothingEntity>> GetClothingforOwner(String ownerid) ;

// Decorations
  Future<void> AddDecorations(DecorationsEntity decorationsEntity) ;
  Future<void> DeleteDecorations(String id);
  Stream<List<DecorationsEntity>> GetDecorationsforClient() ;
  Stream<List<DecorationsEntity>> GetDecorationsforOwner(String ownerid) ;
  Future<void> UpdateDecorations(DecorationsEntity decorationsEntity) ;
  
  // Entertainment
  Future<void> AddEntertainment(EntertainmentEntity entertainmentEntity);
  Future<void> DeleteEntertainment(String id) ;
  Future<void> UpdateEntertainment(EntertainmentEntity entertainmentEntity);
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient() ;
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid);

  // InvitationDesign
  Future<void> AddInvitationDesign(InvitationDesignEntity invitationDesignEntity); 
  Future<void> DeleteInvitationDesign(String id);
  Future<void> UpdateInvitationDesign(InvitationDesignEntity invitationDesignEntity);
  Stream<List<InvitationDesignEntity>> GetInvitationDesignforClient();
  Stream<List<InvitationDesignEntity>> GetInvitationDesignforOwner(String ownerid);
  
// Photography
  Future<void> AddPhotography(PhotographyEntity photographyEntity);  
  Future<void> DeletePhotography(String id) ;
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity);
  Stream<List<PhotographyEntity>> GetPhotographyforClient();
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid) ;

  // Sweet
  Future<void> AddSweets(SweetEntity sweetEntity) ;
  Future<void> DeleteSweets(String id) ;
  Future<void> UpdateSweets(SweetEntity sweetEntity) ;
  Stream<List<SweetEntity>> GetSweetsforClient() ;
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid);

// Transportation
  Future<void> AddTransportation(TransportationEntity transportationEntity) ;
  Future<void> DeleteTransportation(String id);
  Future<void> UpdateTransportation(TransportationEntity transportationEntity);
  Stream<List<TransportationEntity>> GetTransportationforClient();
  Stream<List<TransportationEntity>> GetTransportationforOwner(String ownerid) ;

// Videography
  Future<void> AddVideography(VideographyEntity videographyEntity) ;
  Future<void> DeleteVideography(String id) ;
  Future<void> UpdateVideography(VideographyEntity videographyEntity) ;
  Stream<List<VideographyEntity>> GetVideographyforClient() ;
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid) ;

}
