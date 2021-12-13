import 'package:get_it/get_it.dart';

import 'core/utils/dialog_service.dart';
import 'core/utils/navigator.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
}
