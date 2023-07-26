import 'package:flutter_bloc/flutter_bloc.dart';

/// A base [Bloc] to be extended by any bloc in the app
/// which will help to add new behavior to each bloc later on.
class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);
}
