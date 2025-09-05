import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyect/services/api_service.dart';

abstract class HeaderState {}

class HeaderInitial extends HeaderState {}

class HeaderLoading extends HeaderState {}

class HeaderLoaded extends HeaderState {
  final Map<String, dynamic> userData;
  HeaderLoaded(this.userData);
}

class HeaderError extends HeaderState {
  final String message;
  HeaderError(this.message);
}

class HeaderCubit extends Cubit<HeaderState> {
  HeaderCubit() : super(HeaderInitial());

  Future<void> loadUserData() async {
    emit(HeaderLoading());
    
    try {
      final userData = await ApiService.fetchUserData();
      emit(HeaderLoaded(userData));
    } catch (e) {
      emit(HeaderError(e.toString()));
    }
  }
}