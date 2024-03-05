import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../models/shoe_model.dart';

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  GetDataBloc() : super(GetDataState(shoes: [])) {
    on<GetDataEvent>((event, emit) async {
      // TODO: implement event handler
      final String response = await rootBundle.loadString('assets/shoes.json');
      final data = jsonDecode(response);
      List<dynamic> shoes = [];
      shoes = data['shoes'].map((e) => Shoe.fromJson(e)).toList();
      emit(GetDataState(shoes: shoes));
    });
  }
}
