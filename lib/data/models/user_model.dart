import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    super.favorites,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snap.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      favorites: List<String>.from(data['favorites'] ?? []),
    );
  }

  Map<String, dynamic> toDocument() {
    return {'email': email, 'displayName': displayName, 'favorites': favorites};
  }
}
