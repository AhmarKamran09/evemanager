import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/domain/entities/service/service_entity.dart';

class TransportationEntity extends ServiceEntity {
  TransportationEntity({
    String? id,
    String? owner_id,
    String? name,
    String? contact,
    String? address,
    List<File>? images,
    List<String>? facilities,
    String? description,
    Map<String, dynamic>? pricingInfo,
  }) : super(
          images: images,
          name: name,
          contact: contact,
          facilities: facilities,
          pricingInfo: pricingInfo,
          description: description,
          id: id,
          owner_id: owner_id,
          address: address,
        );

  factory TransportationEntity.factory(
      DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return TransportationEntity(
      images: imagesfromstorage,
      name: snap['name'],
      contact: snap['contact'],
      // facilities: snap['facilities'],
      pricingInfo: snap['pricingInfo'],
      description: snap['description'],
      id: snap['id'],
      owner_id: snap['owner_id'],
      address: snap['address'],
    );
  }

  @override
  List<Object?> get props => [
        images,
        name,
        contact,
        facilities,
        pricingInfo,
        description,
        id,
        owner_id,
        address,
      ];
}
