import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  final String? name;
  final String? uid;
  final String? role;
  final String? contact_number;
  final String? cnic;
  final String? address;

  UserModel({
    this.uid,
    this.name,
    this.role,
    this.contact_number,
    this.cnic,
    this.address,
  }) : super(
          address: address,
          uid: uid,
          name: name,
          role: role,
          contact_number: contact_number,
          cnic: cnic,
        );

  factory UserModel.factory(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snap['uid'],
      name: snap['name'],
      role: snap['role'],
      contact_number: snap['contact_number'],
      cnic: snap['cnic'],
      address: snap['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'role': role,
        'contact_number': contact_number,
        'cnic': cnic,
        'address': address,
      };

  @override
  List<Object?> get props => [
        uid,
        name,
        role,
        contact_number,
        cnic,
        address,
      ];
}
