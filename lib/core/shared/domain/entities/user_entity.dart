import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String nimNip;
  final String? nidn;
  final String email;
  final String name;
  final String? grade;
  final String? generation;
  final String? instance;
  final String? course;
  final String photo;
  final AccountType accountType;

  const User({
    required this.id,
    required this.nimNip,
    required this.nidn,
    required this.email,
    required this.name,
    required this.grade,
    required this.generation,
    required this.instance,
    required this.course,
    required this.photo,
    required this.accountType,
  });

  @override
  List<Object?> get props => [
        id,
        nimNip,
        nidn,
        email,
        name,
        grade,
        generation,
        instance,
        course,
        photo,
        accountType,
      ];
}
