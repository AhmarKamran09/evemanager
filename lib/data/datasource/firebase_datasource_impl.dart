import 'dart:async';
import 'dart:io';
import 'package:evemanager/data/models/catering_model/catering_model.dart';
import 'package:evemanager/domain/entities/catering/catering_entity.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/constants.dart';
import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/data/models/marriage_hall_model/marriage_hall_model.dart';
import 'package:evemanager/data/models/user/user_model.dart';
import 'package:evemanager/domain/entities/marriage_halls/marriage_hall_entity.dart';
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

// Marriage Halls

  @override
  Future<void> AddMarriageHall(MarriageHallEntity marriageHallEntity) async {
    List<String> imagelinks = [];

    try {
      String autoId = FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.marriagehall)
          .doc()
          .id;
      Reference hallfolderref =
          storage.ref().child(FirebaseCollectionConst.marriagehall);
      Reference subfolderRef = hallfolderref.child(autoId);

      for (int i = 0; i < marriageHallEntity.images!.length; i++) {
        File imageFile = marriageHallEntity.images![i];
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference imageRef = subfolderRef.child('$imageName.jpg');
        await imageRef.putFile(imageFile);

        imagelinks.add(await imageRef.getDownloadURL());
      }

      await firebaseFirestore
          .collection(FirebaseCollectionConst.marriagehall)
          .doc(autoId)
          .set(MarriageHallModel(
            imageslink: imagelinks,
            id: autoId,
            owner_id: marriageHallEntity.owner_id,
            address: marriageHallEntity.address,
            name: marriageHallEntity.name,
            capacity: marriageHallEntity.capacity,
            contact: marriageHallEntity.contact,
            facilities: marriageHallEntity.facilities,
            availability: marriageHallEntity.availability,
            pricingInfo: marriageHallEntity.pricingInfo,
            description: marriageHallEntity.description,
          ).toJson());
    } catch (e) {
      DisplayToast('error in add marriage hall ${e.toString()}');
    }
  }

  @override
  Future<void> DeleteMarriageHall(String id) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.marriagehall);
      Reference subfolderRef = mainFolderRef.child(id);
      ListResult listResult = await subfolderRef.listAll();
      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await firebaseFirestore
          .collection(FirebaseCollectionConst.marriagehall)
          .doc(id)
          .delete();
    } catch (e) {
      DisplayToast(e.toString());
    }
  }

  @override
  Stream<List<MarriageHallEntity>> GetMarriageHallforClient() {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.marriagehall)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<MarriageHallEntity> marriageHalls = [];

      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          MarriageHallEntity hall =
              MarriageHallEntity.factory(document, pictures);

          marriageHalls.add(hall);
        }
      }
      return marriageHalls;
    }).handleError((error) {
      DisplayToast('Error in GetMarriageHallforClient: $error');
    });
  }

  @override
  Stream<List<MarriageHallEntity>> GetMarriageHallforOwner(String ownerid) {
    return firebaseFirestore
        .collection(FirebaseCollectionConst.marriagehall)
        .where('owner_id', isEqualTo: ownerid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<MarriageHallEntity> marriageHalls = [];
      for (var document in querySnapshot.docs) {
        var imagesLinkdoc = document['imageslink'];
        if (imagesLinkdoc != null) {
          List<String>? imagelinks = [];
          for (var element in imagesLinkdoc) {
            imagelinks.add(element.toString());
          }

          List<File>? pictures = await getPictures(imagelinks);

          MarriageHallEntity hall =
              MarriageHallEntity.factory(document, pictures);

          marriageHalls.add(hall);
        }
      }
      return marriageHalls;
    }).handleError((error) {
      DisplayToast('Error in GetMarriageHallforOwner: $error');
    });
  }

  @override
  Future<void> UpdateMarriageHall(MarriageHallEntity marriageHallEntity) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.marriagehall)
          .doc(marriageHallEntity.id!)
          .update({
        'name': marriageHallEntity.name,
        'capacity': marriageHallEntity.capacity,
        'contact': marriageHallEntity.contact,
        'facilities': marriageHallEntity.facilities,
        'pricingInfo': marriageHallEntity.pricingInfo,
        'description': marriageHallEntity.description,
      });
    } catch (e) {
      DisplayToast('Error in Update Marriage Hall: $e');
    }
  }

  @override
  Future<void> EditAvailabilityOfHall(
      String hallid, Map<String, bool> availability) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionConst.marriagehall)
          .doc(hallid)
          .update({
        'availability': availability,
      });
    } catch (e) {
      DisplayToast("Editting of Availability Failed: $e.toString()");
    }
  }

  @override
  Future<void> UpdateMarriageHallPictures(String id, List<File>? images) async {
    try {
      Reference mainFolderRef =
          storage.ref().child(FirebaseCollectionConst.marriagehall);
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
          .collection(FirebaseCollectionConst.marriagehall)
          .doc(id)
          .update({
        'imageslink': imagelinks,
      });
    } catch (e) {
      DisplayToast("Update Marriage Hall Pictures: $e.toString()");
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
      Reference hallfolderref =
          storage.ref().child(FirebaseCollectionConst.catering);
      Reference subfolderRef = hallfolderref.child(autoId);

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

          CateringEntity hall = CateringEntity.factory(document, pictures);

          catering_entity.add(hall);
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

          CateringEntity hall = CateringEntity.factory(document, pictures);

          catering_entity.add(hall);
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
}
