import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'authentification/data/authentification_remote_data_source.dart';
import 'authentification/data/authentification_repository_impl.dart';
import 'authentification/domain/authentification_repository.dart';
import 'authentification/domain/usecases/login.dart';
import 'network/network_info.dart';
import 'util/input_validator.dart';

final sl = StackedLocator.instance;

// ignore: avoid_void_async
Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  sl.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Use cases
  sl.registerLazySingleton(() => Login(sl()));

// Repository
  sl.registerLazySingleton<AuthentificationRepository>(() =>
      AuthentificationRepositoryImpl(
          remoteDataSource: sl(), networkInfo: sl()));

// Data source
  sl.registerLazySingleton<AuthentificationRemoteDataSource>(
      () => AuthentificationRemoteDataSourceImpl());

// Core
  sl.registerLazySingleton(() => InputValidator());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// External
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => DialogService());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
