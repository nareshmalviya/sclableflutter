import 'package:get_it/get_it.dart';
import 'cubit/user_cubit.dart';
import 'service/api_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerFactory(() => UserCubit(getIt<ApiService>()));
}
