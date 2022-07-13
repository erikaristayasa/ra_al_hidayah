import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit(int initialState) : super(initialState);

  void change(int i) => emit(i);
}
