import 'package:evemanager/domain/entities/bridal_makeup_&_hair/bridal_makeup_&_hair_entity.dart';

class BridalMakeupAndHairModel extends BridalMakeupAndHairEntity  {
  final String? id;
  final String? owner_id;
  final String? name;
  final String? contact;
  final String? address;
  final List<String>? imageslink;
  final List<String>? facilities;
  final String? description;
  final Map<String, dynamic>? pricingInfo;
  final int? capacity;
 
  BridalMakeupAndHairModel({
    this.imageslink,
    this.name,
    this.capacity,
    this.contact,
    this.facilities,
    this.pricingInfo,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  }) : super();

  Map<String, dynamic> toJson() => {
        'imageslink': imageslink,
        'name': name,
        'capacity': capacity,
        'contact': contact,
        'facilities': facilities,
        'pricingInfo': pricingInfo,
        'description': description,
        'id': id,
        'owner_id': owner_id,
        'address': address,
      };


  @override
  List<Object?> get props => [
        imageslink,
        name,
        capacity,
        contact,
        facilities,
        pricingInfo,
        description,
        id,
        owner_id,
        address,
      ];
}
