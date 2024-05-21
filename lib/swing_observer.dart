import 'package:bloc/bloc.dart';

/// {@template swing_observer}
/// A [BlocObserver] which observes all [Bloc] state changes.
/// {@endtemplate}
class SwingObserver extends BlocObserver{
  /// {@macro swing_observer}
  const SwingObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    
    super.onChange(bloc, change);
    //ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }
}