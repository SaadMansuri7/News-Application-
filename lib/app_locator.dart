import 'package:get_it/get_it.dart';
import 'package:newsapp/app_router.dart';

final locator = GetIt.instance;

void setupLocator() {
  if (!locator.isRegistered<AppRouter>()) {
    locator.registerSingleton<AppRouter>(AppRouter());
  }
}
