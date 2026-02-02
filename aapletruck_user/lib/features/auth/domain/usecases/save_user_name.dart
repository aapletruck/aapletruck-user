import '../entities/user_entity.dart';

class SaveUserName {
  /// Pure domain transformation
  /// (later you can sync this to backend)
  UserEntity call({
    required UserEntity user,
    required String firstName,
    String? lastName,
  }) {
    return user.copyWith(firstName: firstName, lastName: lastName);
  }
}
