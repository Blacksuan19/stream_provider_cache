import 'package:flutter_riverpod/flutter_riverpod.dart';

/// generic  state class, used to track any state of StateType
class GenericStateNotifier<StateType> extends StateNotifier<StateType> {
  GenericStateNotifier(StateType state) : super(state);

  void setState(StateType newState) => state = newState;
}
