import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

final sl = StackedLocator.instance;

// ignore: avoid_void_async
Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  sl.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// External
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => DialogService());
}
