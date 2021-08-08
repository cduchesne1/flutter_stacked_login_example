import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../error/failures.dart';

import '../authentification_repository.dart';

class Login {
  final AuthentificationRepository repository;

  Login(this.repository);

  Future<Either<Failure, bool>> call(Params params) async {
    return repository.login(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
