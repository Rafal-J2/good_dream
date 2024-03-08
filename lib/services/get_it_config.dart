import 'package:get_it/get_it.dart';
import 'package:good_dream/services/timer_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<TimerService>(TimerService(4500));
}
