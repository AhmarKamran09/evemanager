import 'dart:io';
import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? id;
  final String? owner_id;
  final String? name;
  final String? contact;
  final String? address;
  final List<File>? images;
  final List<String>? facilities;
  final String? description;
  final Map<String, dynamic>? pricingInfo;

  ServiceEntity({
    this.id,
    this.owner_id,
    this.name,
    this.contact,
    this.address,
    this.images,
    this.facilities,
    this.description,
    this.pricingInfo,
  });

  // factory ServiceEntity.factory(
  //     DocumentSnapshot snapshot, List<File>? imagesfromstorage) {
  //   var snap = snapshot.data() as Map<String, dynamic>;

  //   return ServiceEntity(
  //     images: imagesfromstorage,
  //     name: snap['name'],
  //     contact: snap['contact'],
  //     // facilities: snap['facilities'],
  //     pricingInfo: snap['pricingInfo'],
  //     description: snap['description'],
  //     id: snap['id'],
  //     owner_id: snap['owner_id'],
  //     address: snap['address'],
  //   );
  // }

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
