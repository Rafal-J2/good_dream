import 'package:get_it/get_it.dart';
import '../bloc/timer/timer_cubit.dart';
import '../services/tab_service.dart';
import '../services/timer_service.dart';

void setupGetIt() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<TabService>(TabService());
  getIt.registerSingleton<TimerService>(TimerService(0));
  getIt
      .registerFactory<TimerCubit>(() => TimerCubit(getIt.get<TimerService>()));
}
