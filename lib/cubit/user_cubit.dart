import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import '../service/api_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiService apiService;
  final ValueNotifier<bool> shouldUpdateUI = ValueNotifier(false);
  UserCubit(this.apiService) : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    try {
      final users = await apiService.fetchUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
