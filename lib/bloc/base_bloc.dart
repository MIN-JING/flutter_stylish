import 'package:bloc/bloc.dart';

abstract class BaseBloc<T> extends Bloc<T, List<dynamic>> {
  BaseBloc(List<dynamic> initialState) : super(initialState);
}
