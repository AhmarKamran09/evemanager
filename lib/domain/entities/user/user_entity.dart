import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? role;
  final String? contact_number;
  final String? cnic;
  final String? address;
  final String? email;
  final String? password;

  UserEntity(
      {this.uid,
      this.role,
      this.contact_number,
      this.cnic,
      this.address,
      this.email,
      this.password,
      this.name});

  @override
  List<Object?> get props => [
        uid,
        name,
        role,
        contact_number,
        email,
        password,
      ];
}
