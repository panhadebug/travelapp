import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password, String displayName);
  Future<void> signOut();
  UserEntity? get currentUser;
}
