import 'package:deliverzler/auth/domain/entities/user.dart';
import 'package:deliverzler/auth/domain/use_cases/sign_in_with_email_uc.dart';

abstract class IAuthRepo {
  Future<User> signInWithEmail(SignInWithEmailParams params);

  Future<String> getUserAuthUid();

  Future<User> getUserData(String uid);

  Future<void> setUserData(User user);

  Future<void> signOut();
}
