import 'package:dartz/dartz.dart';

import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../../network/network_info.dart';
import '../domain/authentification_repository.dart';
import 'authentification_remote_data_source.dart';

class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final AuthentificationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthentificationRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.login(email, password));
      } on AuthentificationException {
        return Left(AuthentificationFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
