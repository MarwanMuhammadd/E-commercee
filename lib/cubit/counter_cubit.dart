import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(value: 0));
  void increment() {
    emit(CounterState(value: state.value + 1, isIncremented: true));
  }

  void decrement() {
    emit(CounterState(value: state.value - 1, isIncremented: false));
  }
}
