import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, BlocBase, BlocObserver, Transition;
import 'package:reminder/cores/logger.dart' show AppLogger;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.i.info('${bloc.runtimeType} $event');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    AppLogger.i.info(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.i.fatal('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }
}
