import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final List<String> favorites;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    this.favorites = const [],
  });

  @override
  List<Object?> get props => [uid, email, displayName, favorites];
}
