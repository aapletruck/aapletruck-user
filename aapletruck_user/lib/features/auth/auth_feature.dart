import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';

/// ===============================
/// AUTH FEATURE DEPENDENCIES
/// ===============================
///
/// This file wires:
/// Domain → Data → Controllers
///
/// Other features should NEVER import
/// AuthRepositoryImpl directly.
///

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
