import 'dart:async';
import 'dart:io';
import 'package:evemanager/data/models/catering_model/catering_model.dart';
import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/clothing/clothing_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
import 'package:evemanager/domain/entities/transportation/transportation_entity.dart';
import 'package:evemanager/domain/entities/videography/videography_entity.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/data/models/venue_model/venue_model.dart';
import 'package:evemanager/data/models/user_model/user_model.dart';
import 'package:evemanager/domain/entities/venues/venue_entity.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseDatasourceImpl implements FirebaseDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage storage;

  FirebaseDatasourceImpl(
      {required this.storage,
      required this.firebaseFirestore,
      required this.firebaseAuth});

// Utility functions

  Future<List<File>> getPictures(List<String>? imagesurl) async {
    List<File> images = [];

    if (imagesurl == null || imagesurl.isEmpty) {
      return images;
    }

    for (int i = 0; i < imagesurl.length; i++) {
      File imageFile = await _downloadImage(imagesurl[i]);
      images.add(imageFile);
    }

    return images;
  }

  Future<File> _downloadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      File tempFile =
          File('$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await tempFile.writeAsBytes(response.bodyBytes);

      return tempFile;
    } else {
      throw Exception('Failed to download image from $imageUrl');
    }
  }

//  User
  Future<String?> GetCurrentUid() async => await firebaseAuth.currentUser?.uid;

  Future<bool> SignInUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      return true;
    } catch (e) {
      DisplayToast(e.toString());
      return false;
    }
  }

  Future<void> SignUpUser(UserEntity user) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      // await firebaseAuth.currentUser?.sendEmailVerification();
      // DisplayToast("Verification Email Sent");
      String newuid = userCredential.user!.uid;
      firebaseFirestore
          .collection(FirebaseCollectionConst.user)
          .doc(newuid)
          .set(UserModel(
            uid: newuid,
            name: user.name,
            role: user.role,
            contact_number: user.contact_number,
            cnic: user.cnic,
            address: user.address,
          ).toJson());
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  Future<void> SignOutUser() async {
    try {
      await firebaseAuth.signOut();
      DisplayToast("Signed Out");
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  Future<bool> IsSignInUser() async => firebaseAuth.currentUser?.uid != null;

  Future<UserEntity> GetUser(String uid) async {
    try {
      return await firebaseFirestore
          .collection(FirebaseCollectionConst.user)
          .doc(uid)
          .get()
          .then((value) => UserModel.factory(value));
    } catch (e) {
      DisplayToast(e.toString());
      return UserEntity(uid: null);
    }
  }

  Future<void> UpdateUser(UserEntity user) async {
    try {
      if (user.uid != null && user.uid!.isNotEmpty) {
        DocumentSnapshot userSnapshot = await firebaseFirestore
            .collection(FirebaseCollectionConst.user)
            .doc(user.uid!)
            .get();

        // Get the current 'role' field value
        String currentRole = userSnapshot['role'];

        await firebaseFirestore
            .collection(FirebaseCollectionConst.user)
            .doc(user.uid!)
            .update(UserModel(
              uid: user.uid,
              name: user.name,
              contact_number: user.contact_number,
              cnic: user.cnic,
              address: user.address,
              role: currentRole,
            ).toJson());
      } else {
        DisplayToast("Error: User UID is null or empty.");
      }
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  Future<void> DeleteUser(String uid) async {
    try {
      if (firebaseAuth.currentUser != null ||
          firebaseAuth.currentUser!.emailVerified) {
        await firebaseFirestore
            .collection(FirebaseCollectionConst.user)
            .doc(uid)
            .delete();
        await firebaseAuth.currentUser!.delete();
        await SignOutUser();
      }
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

// Venues

  @override
  Future<void> AddVenue(VenueEntity venueEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.venues)
          .doc()
          .id;
      Reference hallfolderref =
          storage.ref().child(FirebaseCollectionConst.venues);
      Reference subfolderRef = hallfolderref.child(autoId);

      for (int i = 0; i < venueEntity.images!.length; i++) {
        File imageFile = venueEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.venues)
          .doc(autoId)
          .set(VenueModel(
            imageslink: imagelinks,
            id: autoId,
            owner_id: venueEntity.owner_id,
            address: venueEntity.address,
            name: venueEntity.name,
            capacity: venueEntity.capacity,
            contact: venueEntity.contact,
            facilities: venueEntity.facilities,
            availability: venueEntity.availability,
            pricingInfo: venueEntity.pricingInfo,
            description: venueEntity.description,
          ).toJson());
    } catch (e) {
      DisplayToast('error in add venue ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteVenue(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.venues);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.venues)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<VenueEntity>> GetVenueforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.venues)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<VenueEntity> venues = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          VenueEntity hall = VenueEntity.factory(document, pictures);

          venues.add(hall);
        }
      }
      return venues;
    }).handleError((error) {
      DisplayToast('Error in GetvenueforClient: $error');
    });
  }

  @override
  Stream<List<VenueEntity>> GetVenueforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.venues)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<VenueEntity> venues = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          VenueEntity hall = VenueEntity.factory(document, pictures);

          venues.add(hall);
        }
      }
      return venues;
    }).handleError((error) {
      DisplayToast('Error in GetVenueforOwner: $error');
    });
  }

  @override
  Future<void> UpdateVenue(VenueEntity venueEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.venues)
          .doc(venueEntity.id!)
          .update({
        'name': venueEntity.name,
        'capacity': venueEntity.capacity,
        'contact': venueEntity.contact,
        'facilities': venueEntity.facilities,
        'pricingInfo': venueEntity.pricingInfo,
        'description': venueEntity.description,
      });
    } catch (e) {
      DisplayToast('Error in Update Venue: $e');
    }
  }

  @override
  Future<void> EditAvailabilityOfVenue(
      String hallid, Map<String, bool> availability) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.venues)
          .doc(hallid)
          .update({
        'availability': availability,
      });
    } catch (e) {
      DisplayToast("Editting of Availability Failed: $e.toString()");
    }
  }

  @override
  Future<void> UpdateVenuePictures(String id, List<File>? images) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.venues);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      List<String> imagelinks = [];

      for (int i = 0; i < images!.length; i++) {
        File imageFile = images[i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);
        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.venues)
          .doc(id)
          .update({
        'imageslink': imagelinks,
      });
    } catch (e) {
      DisplayToast("Update Venue Pictures: $e.toString()");
    }
  }

// Catering Service

  @override
  Future<void> AddCateringService(CateringEntity cateringEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.catering)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.catering);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < cateringEntity.images!.length; i++) {
        File imageFile = cateringEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.catering)
          .doc(autoId)
          .set(CateringModel(
            cuisinetype: cateringEntity.cuisinetype,
            menu: cateringEntity.menu,
            imageslink: imagelinks,
            id: autoId,
            owner_id: cateringEntity.owner_id,
            address: cateringEntity.address,
            name: cateringEntity.name,
            capacity: cateringEntity.capacity,
            contact: cateringEntity.contact,
            facilities: cateringEntity.facilities,
            availability: cateringEntity.availability,
            pricingInfo: cateringEntity.pricingInfo,
            description: cateringEntity.description,
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Catering ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteCateringService(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.catering);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.catering)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<CateringEntity>> GetCateringServiceforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.catering)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<CateringEntity> catering_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          CateringEntity catering = CateringEntity.factory(document, pictures);

          catering_entity.add(catering);
        }
      }
      return catering_entity;
    }).handleError((error) {
      DisplayToast('Error in GetCateringforClient: $error');
    });
  }

  @override
  Stream<List<CateringEntity>> GetCateringServiceforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.catering)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<CateringEntity> catering_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          CateringEntity catering = CateringEntity.factory(document, pictures);

          catering_entity.add(catering);
        }
      }
      return catering_entity;
    }).handleError((error) {
      DisplayToast('Error in GetCateringforOwner: $error');
    });
  }

  @override
  Future<void> UpdateCateringService(CateringEntity cateringEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.catering)
          .doc(cateringEntity.id!)
          .update({
        'cuisinetype': cateringEntity.cuisinetype,
        'menu': cateringEntity.menu,
        'name': cateringEntity.name,
        'capacity': cateringEntity.capacity,
        'contact': cateringEntity.contact,
        'facilities': cateringEntity.facilities,
        'pricingInfo': cateringEntity.pricingInfo,
        'description': cateringEntity.description,
      });
    } catch (e) {
      DisplayToast('Error in Update Catering Service: $e');
    }
  }

// BridalMakeupAndHair

  @override
  Future<void> AddBridalMakeupAndHair(
      BridalMakeupAndHairEntity bridalMakeupAndHairEntity) async {
    //  List<String> imagelinks = [];

    // try {
    //   String autoId = FirebaseFirestore.instance
    //       .collection(FirebaseCollectionConst.bridalMakeupAndHair)
    //       .doc()
    //       .id;
    //   Reference Bridalfolderref =
    //       storage.ref().child(FirebaseCollectionConst.bridalMakeupAndHair);
    //   Reference subfolderRef = Bridalfolderref.child(autoId);

    //   for (int i = 0; i < bridalMakeupAndHairEntity.images!.length; i++) {
    //     File imageFile = bridalMakeupAndHairEntity.images![i];
    //     String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //     Reference imageRef = subfolderRef.child('$imageName.jpg');
    //     await imageRef.putFile(imageFile);

    //     imagelinks.add(await imageRef.getDownloadURL());
    //   }

    //   await firebaseFirestore
    //       .collection(FirebaseCollectionConst.bridalMakeupAndHair)
    //       .doc(autoId)
    //       .set(CateringModel(
    //         cuisinetype: cateringEntity.cuisinetype,
    //         menu:  cateringEntity.menu,
    //         imageslink: imagelinks,
    //         id: autoId,
    //         owner_id: cateringEntity.owner_id,
    //         address: cateringEntity.address,
    //         name: cateringEntity.name,
    //         capacity: cateringEntity.capacity,
    //         contact: cateringEntity.contact,
    //         facilities: cateringEntity.facilities,
    //         availability: cateringEntity.availability,
    //         pricingInfo: cateringEntity.pricingInfo,
    //         description: cateringEntity.description,
    //       ).toJson());
    // } catch (e) {
    //   DisplayToast('error in add Catering ${e.toString()}');
    // }
  }

  @override
  Future<void> DeleteBridalMakeupAndHair(String id) {
    // TODO: implement DeleteBridalMakeupAndHair
    throw UnimplementedError();
  }

  @override
  Stream<List<BridalMakeupAndHairEntity>> GetBridalMakeupAndHairforClient() {
    // TODO: implement GetBridalMakeupAndHairforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<BridalMakeupAndHairEntity>> GetBridalMakeupAndHairforOwner(
      String ownerid) {
    // TODO: implement GetBridalMakeupAndHairforOwner
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateBridalMakeupAndHair(
      BridalMakeupAndHairEntity bridalMakeupAndHairEntity) {
    // TODO: implement UpdateBridalMakeupAndHair
    throw UnimplementedError();
  }

  @override
  Future<void> AddClothing(ClothingEntity clothingEntity) {
    // TODO: implement AddClothing
    throw UnimplementedError();
  }

  @override
  Future<void> AddDecorations(DecorationsEntity decorationsEntity) {
    // TODO: implement AddDecorations
    throw UnimplementedError();
  }

  @override
  Future<void> AddEntertainment(EntertainmentEntity entertainmentEntity) {
    // TODO: implement AddEntertainment
    throw UnimplementedError();
  }

  @override
  Future<void> AddInvitationDesign(InvitationDesignEntity invitationDesignEntity) {
    // TODO: implement AddInvitationDesign
    throw UnimplementedError();
  }

  @override
  Future<void> AddPhotography(PhotographyEntity photographyEntity) {
    // TODO: implement AddPhotography
    throw UnimplementedError();
  }

  @override
  Future<void> AddSweets(SweetEntity sweetEntity) {
    // TODO: implement AddSweets
    throw UnimplementedError();
  }

  @override
  Future<void> AddTransportation(TransportationEntity transportationEntity) {
    // TODO: implement AddTransportation
    throw UnimplementedError();
  }

  @override
  Future<void> AddVideography(VideographyEntity videographyEntity) {
    // TODO: implement AddVideography
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteClothing(String id) {
    // TODO: implement DeleteClothing
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteDecorations(String id) {
    // TODO: implement DeleteDecorations
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteEntertainment(String id) {
    // TODO: implement DeleteEntertainment
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteInvitationDesign(String id) {
    // TODO: implement DeleteInvitationDesign
    throw UnimplementedError();
  }

  @override
  Future<void> DeletePhotography(String id) {
    // TODO: implement DeletePhotography
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteSweets(String id) {
    // TODO: implement DeleteSweets
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteTransportation(String id) {
    // TODO: implement DeleteTransportation
    throw UnimplementedError();
  }

  @override
  Future<void> DeleteVideography(String id) {
    // TODO: implement DeleteVideography
    throw UnimplementedError();
  }

  @override
  Stream<List<ClothingEntity>> GetClothingforClient() {
    // TODO: implement GetClothingforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<ClothingEntity>> GetClothingforOwner(String ownerid) {
    // TODO: implement GetClothingforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforClient() {
    // TODO: implement GetDecorationsforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforOwner(String ownerid) {
    // TODO: implement GetDecorationsforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient() {
    // TODO: implement GetEntertainmentforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid) {
    // TODO: implement GetEntertainmentforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<InvitationDesignEntity>> GetInvitationDesignforClient() {
    // TODO: implement GetInvitationDesignforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<InvitationDesignEntity>> GetInvitationDesignforOwner(String ownerid) {
    // TODO: implement GetInvitationDesignforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforClient() {
    // TODO: implement GetPhotographyforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid) {
    // TODO: implement GetPhotographyforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforClient() {
    // TODO: implement GetSweetsforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid) {
    // TODO: implement GetSweetsforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<TransportationEntity>> GetTransportationforClient() {
    // TODO: implement GetTransportationforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<TransportationEntity>> GetTransportationforOwner(String ownerid) {
    // TODO: implement GetTransportationforOwner
    throw UnimplementedError();
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforClient() {
    // TODO: implement GetVideographyforClient
    throw UnimplementedError();
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid) {
    // TODO: implement GetVideographyforOwner
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateClothing(ClothingEntity clothingEntity) {
    // TODO: implement UpdateClothing
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateDecorations(DecorationsEntity decorationsEntity) {
    // TODO: implement UpdateDecorations
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateEntertainment(EntertainmentEntity entertainmentEntity) {
    // TODO: implement UpdateEntertainment
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateInvitationDesign(InvitationDesignEntity invitationDesignEntity) {
    // TODO: implement UpdateInvitationDesign
    throw UnimplementedError();
  }

  @override
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity) {
    // TODO: implement UpdatePhotography
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateSweets(SweetEntity sweetEntity) {
    // TODO: implement UpdateSweets
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateTransportation(TransportationEntity transportationEntity) {
    // TODO: implement UpdateTransportation
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateVideography(VideographyEntity videographyEntity) {
    // TODO: implement UpdateVideography
    throw UnimplementedError();
  }
}
