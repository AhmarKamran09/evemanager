
class ServiceModel  {
  final String? id;
  final String? owner_id;
  final String? address;
  final List<String>? imageslink;
  final String? name;
  final String? contact;
  final List<String>? facilities;
  final Map<String, dynamic>? pricingInfo;
  final String? description;

  ServiceModel({
    this.imageslink,
    this.name,
    this.contact,
    this.facilities,
    this.pricingInfo,
    this.description,
    this.id,
    this.owner_id,
    this.address,
  }) ;

  // Map<String, dynamic> toJson() => {
  //       'imageslink': imageslink,
  //       'name': name,
  //       'contact': contact,
  //       'facilities': facilities,
  //       'pricingInfo': pricingInfo,
  //       'description': description,
  //       'id': id,
  //       'owner_id': owner_id,
  //       'address': address,
  //     };

  // @override
  // List<Object?> get props => [
  //       imageslink,
  //       name,
  //       contact,
  //       facilities,
  //       pricingInfo,
  //       description,
  //       id,
  //       owner_id,
  //       address,
  //     ];
}
