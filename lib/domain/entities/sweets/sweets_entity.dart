import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SweetEntity extends Equatable {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<File>? images;
  final String? name;
  final String? contact;
  final List<String>? facilities;
  final Map<String, dynamic>? pricingInfo;
  final Map<String, Map<String, bool>>? availability;
  final String? description;
 
  SweetEntity({
    this.images,
    this.name,
    this.contact,
    this.facilities,
    this.pricingInfo,
    this.availability,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  });

  factory SweetEntity.factory(
      DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return SweetEntity(
      images: imagesfromstorage,
      name: snap['name'],
      contact: snap['contact'],
      // facilities: snap['facilities'],
      pricingInfo: snap['pricingInfo'],
      availability: snap['availability'],
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
        availability,
        description,
        id,
        owner_id,
        address,
      ];
}

