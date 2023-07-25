import 'package:flutter_bloc/flutter_bloc.dart';

/// A base [Cubit] to be extended by any cubit in the app
/// which will help to add new behavior to each cubit later on.
class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);
}
