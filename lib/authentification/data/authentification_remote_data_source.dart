import '../../error/exceptions.dart';

abstract class AuthentificationRemoteDataSource {
  /// Try to login via the Parse server.
  ///
  /// Throws a [AuthentificationException] for all error codes.
  Future<bool> login(String email, String password);
}

class AuthentificationRemoteDataSourceImpl
    implements AuthentificationRemoteDataSource {
  @override
  Future<bool> login(String email, String password) async {
    final expectedEmail = 'test@email.com';
    final expectedPassword = 'password';

    Future.delayed(const Duration(milliseconds: 50));

    if (email == expectedEmail && password == expectedPassword) {
      return true;
    } else {
      throw AuthentificationException();
    }
  }
}
