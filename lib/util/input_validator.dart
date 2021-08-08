import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputValidator {
  Either<Failure, bool> validateEmailInput(String? str) {
    if (str != null && str.isNotEmpty) {
      final bool emailIsValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(str);

      if (emailIsValid) {
        return const Right(true);
      } else {
        return Left(InvalidInputFailure());
      }
    } else {
      return Left(InvalidInputFailure());
    }
  }
}
