import 'package:stacked/stacked_annotations.dart';

import '../authentification/presentation/authentification_view.dart';
import '../home/presentation/home_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: AuthentificationView, initial: true),
  MaterialRoute(page: MyHomePage)
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
