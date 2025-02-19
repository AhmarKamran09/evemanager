import 'dart:async';
import 'dart:io';
import 'package:evemanager/data/models/catering_model/catering_model.dart';
import 'package:evemanager/data/models/decorations_model/decorations_model.dart';
import 'package:evemanager/data/models/entertainment_model/entertainment_model.dart';
import 'package:evemanager/data/models/message_model/chat_model.dart';
import 'package:evemanager/data/models/message_model/message_model.dart';
import 'package:evemanager/data/models/photography_model/photography_model.dart';
import 'package:evemanager/data/models/rating_model/rating_model.dart';
import 'package:evemanager/data/models/sweets_model/sweets_model.dart';
import 'package:evemanager/data/models/videography_model/videography_model.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:evemanager/domain/entities/decorations/decorations_entity.dart';
import 'package:evemanager/domain/entities/entertainment/entertainment_entity.dart';
import 'package:evemanager/domain/entities/message/chat_entity.dart';
import 'package:evemanager/domain/entities/message/message_entity.dart';
import 'package:evemanager/domain/entities/photography/photography_entity.dart';
import 'package:evemanager/domain/entities/rating_entity/rating_entity.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';
import 'package:evemanager/domain/entities/sweets/sweets_entity.dart';
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

  String chatRoomId(String clientid, String adminid, String serviceid) {
    if (clientid[0].toLowerCase().codeUnits[0] >
        adminid.toLowerCase().codeUnits[0]) {
      return "$clientid$adminid$serviceid";
    } else {
      return "$adminid$clientid$serviceid";
    }
  }

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
            contact: cateringEntity.contact,
            facilities: cateringEntity.facilities,
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
        'contact': cateringEntity.contact,
        'facilities': cateringEntity.facilities,
        'pricingInfo': cateringEntity.pricingInfo,
        'description': cateringEntity.description,
      });
    } catch (e) {
      DisplayToast('Error in Update Catering Service: $e');
    }
  }
// Decorations

  @override
  Future<void> AddDecorations(DecorationsEntity decorationsEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.decorations)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.decorations);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < decorationsEntity.images!.length; i++) {
        File imageFile = decorationsEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.decorations)
          .doc(autoId)
          .set(DecorationModel(
            // Assuming DecorationsModel is the corresponding model
            // Adjust the fields accordingly
            // type: decorationsEntity.type,
            // brand: decorationsEntity.brand,
            imageslink: imagelinks,
            id: autoId,
            owner_id: decorationsEntity.owner_id,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Decorations Service ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteDecorations(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.decorations);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.decorations)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.decorations)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<DecorationsEntity> decorations_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          DecorationsEntity decorations =
              DecorationsEntity.factory(document, pictures);

          decorations_entity.add(decorations);
        }
      }
      return decorations_entity;
    }).handleError((error) {
      DisplayToast('Error in GetDecorationsforClient: $error');
    });
  }

  @override
  Stream<List<DecorationsEntity>> GetDecorationsforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.decorations)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<DecorationsEntity> decorations_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          DecorationsEntity decorations =
              DecorationsEntity.factory(document, pictures);

          decorations_entity.add(decorations);
        }
      }
      return decorations_entity;
    }).handleError((error) {
      DisplayToast('Error in GetDecorationsforOwner: $error');
    });
  }

  @override
  Future<void> UpdateDecorations(DecorationsEntity decorationsEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.decorations)
          .doc(decorationsEntity.id!)
          .update({
        // 'type': decorationsEntity.type,
        // 'brand': decorationsEntity.brand,
        // Add other fields as needed
      });
    } catch (e) {
      DisplayToast('Error in Update Decorations Service: $e');
    }
  }

  // Entertainment
  @override
  Future<void> AddEntertainment(EntertainmentEntity entertainmentEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.entertainment)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.entertainment);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < entertainmentEntity.images!.length; i++) {
        File imageFile = entertainmentEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.entertainment)
          .doc(autoId)
          .set(EntertainmentModel(
            // Assuming EntertainmentModel is the corresponding model
            // Adjust the fields accordingly
            // type: entertainmentEntity.type,
            // brand: entertainmentEntity.brand,
            imageslink: imagelinks,
            id: autoId,
            owner_id: entertainmentEntity.owner_id,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Entertainment Service ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteEntertainment(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.entertainment);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.entertainment)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.entertainment)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<EntertainmentEntity> entertainment_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          EntertainmentEntity entertainment =
              EntertainmentEntity.factory(document, pictures);

          entertainment_entity.add(entertainment);
        }
      }
      return entertainment_entity;
    }).handleError((error) {
      DisplayToast('Error in GetEntertainmentServiceForClient: $error');
    });
  }

  @override
  Stream<List<EntertainmentEntity>> GetEntertainmentforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.entertainment)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<EntertainmentEntity> entertainment_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          EntertainmentEntity entertainment =
              EntertainmentEntity.factory(document, pictures);

          entertainment_entity.add(entertainment);
        }
      }
      return entertainment_entity;
    }).handleError((error) {
      DisplayToast('Error in GetEntertainmentServiceForOwner: $error');
    });
  }

  @override
  Future<void> UpdateEntertainment(
      EntertainmentEntity entertainmentEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.entertainment)
          .doc(entertainmentEntity.id!)
          .update({
        // 'type': entertainmentEntity.type,
        // 'brand': entertainmentEntity.brand,
        // Add other fields as needed
      });
    } catch (e) {
      DisplayToast('Error in Update Entertainment Service: $e');
    }
  }

// Photography
  @override
  Future<void> AddPhotography(PhotographyEntity photographyEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.photography)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.photography);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < photographyEntity.images!.length; i++) {
        File imageFile = photographyEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.photography)
          .doc(autoId)
          .set(PhotographyModel(
            // Assuming PhotographyModel is the corresponding model
            // Adjust the fields accordingly
            // type: photographyEntity.type,
            // brand: photographyEntity.brand,
            imageslink: imagelinks,
            id: autoId,
            owner_id: photographyEntity.owner_id,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Photography Service ${e.toString()}');
    }
  }

  @override
  Future<void> DeletePhotography(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.photography);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.photography)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.photography)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<PhotographyEntity> photography_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          PhotographyEntity photography =
              PhotographyEntity.factory(document, pictures);

          photography_entity.add(photography);
        }
      }
      return photography_entity;
    }).handleError((error) {
      DisplayToast('Error in GetPhotographyServiceForClient: $error');
    });
  }

  @override
  Stream<List<PhotographyEntity>> GetPhotographyforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.photography)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<PhotographyEntity> photography_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          PhotographyEntity photography =
              PhotographyEntity.factory(document, pictures);

          photography_entity.add(photography);
        }
      }
      return photography_entity;
    }).handleError((error) {
      DisplayToast('Error in GetPhotographyServiceForOwner: $error');
    });
  }

  @override
  Future<void> UpdatePhotography(PhotographyEntity photographyEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.photography)
          .doc(photographyEntity.id!)
          .update({
        // 'type': photographyEntity.type,
        // 'brand': photographyEntity.brand,
        // Add other fields as needed
      });
    } catch (e) {
      DisplayToast('Error in Update Photography Service: $e');
    }
  }

// Sweet
  @override
  Future<void> AddSweets(SweetEntity sweetEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.sweets)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.sweets);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < sweetEntity.images!.length; i++) {
        File imageFile = sweetEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.sweets)
          .doc(autoId)
          .set(SweetsModel(
            // Assuming SweetModel is the corresponding model
            // Adjust the fields accordingly
            // type: sweetEntity.type,
            // brand: sweetEntity.brand,
            imageslink: imagelinks,
            id: autoId,
            owner_id: sweetEntity.owner_id,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Sweet Service ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteSweets(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.sweets);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.sweets)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.sweets)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<SweetEntity> sweet_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          SweetEntity sweet = SweetEntity.factory(document, pictures);

          sweet_entity.add(sweet);
        }
      }
      return sweet_entity;
    }).handleError((error) {
      DisplayToast('Error in GetSweetServiceForClient: $error');
    });
  }

  @override
  Stream<List<SweetEntity>> GetSweetsforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.sweets)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<SweetEntity> sweet_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          SweetEntity sweet = SweetEntity.factory(document, pictures);

          sweet_entity.add(sweet);
        }
      }
      return sweet_entity;
    }).handleError((error) {
      DisplayToast('Error in GetSweetServiceForOwner: $error');
    });
  }

  @override
  Future<void> UpdateSweets(SweetEntity sweetEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.sweets)
          .doc(sweetEntity.id!)
          .update({
        // 'type': sweetEntity.type,
        // 'brand': sweetEntity.brand,
        // Add other fields as needed
      });
    } catch (e) {
      DisplayToast('Error in Update Sweet Service: $e');
    }
  }

// Videography
  @override
  Future<void> AddVideography(VideographyEntity videographyEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.videography)
          .doc()
          .id;
      Reference venuefolderref =
          storage.ref().child(FirebaseCollectionConst.videography);
      Reference subfolderRef = venuefolderref.child(autoId);

      for (int i = 0; i < videographyEntity.images!.length; i++) {
        File imageFile = videographyEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.videography)
          .doc(autoId)
          .set(VideographyModel(
            // Assuming VideographyModel is the corresponding model
            // Adjust the fields accordingly
            // type: videographyEntity.type,
            // brand: videographyEntity.brand,
            imageslink: imagelinks,
            id: autoId,
            owner_id: videographyEntity.owner_id,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Videography Service ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteVideography(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.videography);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.videography)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.videography)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<VideographyEntity> videography_entity = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          VideographyEntity videography =
              VideographyEntity.factory(document, pictures);

          videography_entity.add(videography);
        }
      }
      return videography_entity;
    }).handleError((error) {
      DisplayToast('Error in GetVideographyServiceForClient: $error');
    });
  }

  @override
  Stream<List<VideographyEntity>> GetVideographyforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.videography)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<VideographyEntity> videography_entity = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imagesLink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          VideographyEntity videography =
              VideographyEntity.factory(document, pictures);

          videography_entity.add(videography);
        }
      }
      return videography_entity;
    }).handleError((error) {
      DisplayToast('Error in GetVideographyServiceForOwner: $error');
    });
  }

  @override
  Future<void> UpdateVideography(VideographyEntity videographyEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.videography)
          .doc(videographyEntity.id!)
          .update({
        // 'type': videographyEntity.type,
        // 'brand': videographyEntity.brand,
        // Add other fields as needed
      });
    } catch (e) {
      DisplayToast('Error in Update Videography Service: $e');
    }
  }

// Chats
  @override
  Stream<List<ChatEntity>> GetChatsForClient(String userid) {
    try {
      Query? finalquery = firebaseFirestore
          .collection(FirebaseCollectionConst.chats)
          .where('user1id', isEqualTo: userid);
      return finalquery.snapshots().asyncMap((snapshot) async {
        List<ChatEntity> chats = [];

        for (var doc in snapshot.docs) {
          chats.add(ChatModel.factory(doc));
        }
        return chats;
      }).handleError((error) {
        DisplayToast('Error in GetChats Client: $error');
      });
    } catch (error) {
      print('Error fetching chats for client: $error');
      throw error;
    }
  }

  @override
  Stream<List<ChatEntity>> GetChatsForAdmin(String userid) {
    try {
      Query? finalquery = firebaseFirestore
          .collection(FirebaseCollectionConst.chats)
          .where('user2id_serviceowner', isEqualTo: userid);
      return finalquery.snapshots().asyncMap((snapshot) async {
        List<ChatEntity> chats = [];

        for (var doc in snapshot.docs) {
          chats.add(ChatModel.factory(doc));
        }
        return chats;
      }).handleError((error) {
        DisplayToast('Error in GetChats Admin: $error');
      });
    } catch (error) {
      print('Error fetching chatsfor admin : $error');
      throw error;
    }
  }

// Messages
  StreamController<List<MessageEntity>> _messageStreamControllerforclient =
      StreamController<List<MessageEntity>>.broadcast();

  Stream<List<MessageEntity>> GetMessages({
    required ChatEntity chatEntity,
    required UserRole userRole,
    required String request_sender_id,
  }) {
    try {
      String chatid = chatRoomId(
        chatEntity.user1id,
        chatEntity.user2id_serviceowner,
        chatEntity.serviceid,
      );
      if (request_sender_id == chatEntity.user1id) {
        firebaseFirestore
            .collection(FirebaseCollectionConst.chats)
            .doc(chatid)
            .update({'unseenMessagesByClient': 0});
      } else if (request_sender_id == chatEntity.user2id_serviceowner) {
        firebaseFirestore
            .collection(FirebaseCollectionConst.chats)
            .doc(chatid)
            .update({'unseenMessagesByAdmin': 0});
      }

      firebaseFirestore
          .collection(FirebaseCollectionConst.chats)
          .doc(chatid)
          .collection(FirebaseCollectionConst.messages)
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snapshot) {
        List<MessageEntity> messages = [];
        for (var doc in snapshot.docs) {
          MessageEntity singlemessage;
          singlemessage = MessageModel.factory(doc);
          // separate logic for showing notification of each side
          messages.add(singlemessage);
        }

        //Update the recent no if unseen messages
        _messageStreamControllerforclient.add(messages);
      }, onError: (error) {
        DisplayToast('Error in GetMessages: $error');
      });

      return _messageStreamControllerforclient.stream.asBroadcastStream();
    } catch (error) {
      print('Error fetching messages: $error');
      throw error;
      // You can handle the error according to your application's logic
    }
  }

  void dispose() {
    _messageStreamControllerforclient.close();
  }

  @override
  Future<void> SendMessage({
    required String clientid,
    required MessageEntity messageEntity,
    required ServiceEntity serviceEntity,
  }) async {
    try {
      String chatid = chatRoomId(
        clientid,
        serviceEntity.owner_id!,
        serviceEntity.id!,
      );
      // Get a reference to the chat document
      DocumentReference chatDocRef = firebaseFirestore
          .collection(FirebaseCollectionConst.chats)
          .doc(chatid);

      // Create the chat document if it doesn't exist
      if (!(await chatDocRef.get()).exists) {
        await chatDocRef.set(ChatModel(
          unseenMessagesByAdmin: 1,
          unseenMessagesByClient: 0,
          servicename: serviceEntity.name!,
          user1id: clientid,
          user2id_serviceowner: serviceEntity.owner_id!,
          serviceid: serviceEntity.id!,
        ).toJson());
      } else {
        if (messageEntity.senderid == clientid) {
          firebaseFirestore
              .collection(FirebaseCollectionConst.chats)
              .doc(chatid)
              .update({'unseenMessagesByAdmin': 1});
        } else {
          firebaseFirestore
              .collection(FirebaseCollectionConst.chats)
              .doc(chatid)
              .update({'unseenMessagesByClient': 1});
        }
      }

      // Add the message to the messages subcollection
      await chatDocRef.collection(FirebaseCollectionConst.messages).add(
            MessageModel(
              seen: false,
              message: messageEntity.message,
              timestamp: Timestamp.now(),
              senderid: messageEntity.senderid,
            ).toJson(),
          );
    } catch (error) {
      print('Error sending message: $error');
    }
  }

// Rating
  @override
  Future<void> AddRating(RatingEntity ratingEntity) async {
    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.rating)
          .doc()
          .id;

      await firebaseFirestore
          .collection(FirebaseCollectionConst.rating)
          .doc(autoId)
          .set(RatingModel(
            // Assuming VideographyModel is the corresponding model
            // Adjust the fields accordingly
            // type: videographyEntity.type,
            // brand: videographyEntity.brand,
            id: autoId,
            // Add other fields as needed
          ).toJson());
    } catch (e) {
      DisplayToast('error in add Rating  ${e.toString()}');
    }
  }

  @override
  Stream<List<RatingEntity>> GetRating(String serviceId) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.rating)
        .where('serviceId', isEqualTo: serviceId)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<RatingEntity> rating_entity = [];
      for (var document in querySnapshot.docs) {
        RatingEntity rating = RatingModel.factory(document);

        rating_entity.add(rating);
      }
      return rating_entity;
    }).handleError((error) {
      DisplayToast('Error in GetRating: $error');
    });
  }
}
