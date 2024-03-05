part of 'get_data_bloc.dart';

class GetDataState {
  final List<dynamic> shoes;
  GetDataState({
    required this.shoes,
  });
  GetDataState copyWith({
    List<dynamic>? shoes,
  }) {
    return GetDataState(
      shoes: shoes ?? this.shoes,
    );
  }
}
