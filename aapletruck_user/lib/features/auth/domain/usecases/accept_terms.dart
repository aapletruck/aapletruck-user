import '../entities/user_entity.dart';

class AcceptTerms {
  UserEntity call(UserEntity user) {
    return user.copyWith(isTermsAccepted: true);
  }
}
