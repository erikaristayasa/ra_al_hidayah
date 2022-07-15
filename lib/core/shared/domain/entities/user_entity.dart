import '../../../statics/statics.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final AccountType accountType;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.accountType,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        address,
        accountType,
      ];
}
