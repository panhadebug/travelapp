import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  UserEntity? _mapUser(User? user) {
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Traveler',
    );
  }

  @override
  Stream<UserEntity?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map(_mapUser);

  @override
  UserEntity? get currentUser => _mapUser(_firebaseAuth.currentUser);

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(cred.user);
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  @override
  Future<UserEntity?> signUp(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await cred.user?.updateDisplayName(displayName);
      return _mapUser(cred.user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
