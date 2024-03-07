import 'package:evemanager/domain/entities/invitation_design/invitation_design_entity.dart';

class InvitationDesignModel extends InvitationDesignEntity {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final int? capacity;
  final String? contact;
  final List<String>? facilities;
  final Map<String, dynamic>? pricingInfo;
  final Map<String, Map<String, bool>>? availability;
  final String? description;

  InvitationDesignModel({
    this.imageslink,
    this.name,
    this.capacity,
    this.contact,
    this.facilities,
    this.pricingInfo,
    this.availability,
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
        'availability': availability,
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
        availability,
        description,
        id,
        owner_id,
        address,
      ];
}
