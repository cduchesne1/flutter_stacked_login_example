import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class AuthentificationRepository {
  Future<Either<Failure, bool>> login(String email, String password);
}
