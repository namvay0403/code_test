import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  bool checkCart(int? id) {
    for (var i = 0; i < state.carts.length; i++) {
      if (state.carts[i].id == id) {
        print(state.carts[i].id);
        return true;
      }
    }
    return false;
  }

  CartBloc() : super(CartInitial(carts: [])) {
    on<CartAddEvent>((event, emit) {
      if (checkCart(event.cartModel.id) == false) {
        state.carts.add(event.cartModel);
        double totalPrice = 0;
        for (var i = 0; i < state.carts.length; i++) {
          totalPrice += state.carts[i].price * state.carts[i].count;
        }
        emit(CartSuccess(totalPrice: totalPrice, carts: state.carts));
      } else {
        double totalPrice = 0;
        for (var i = 0; i < state.carts.length; i++) {
          totalPrice += state.carts[i].price * state.carts[i].count;
        }
        emit(CartSuccess(totalPrice: totalPrice, carts: state.carts));
      }
    });
    on<CartPlusEvent>((event, emit) {
      for (var i = 0; i < state.carts.length; i++) {
        if (state.carts[i].id == event.id) {
          state.carts[i].count++;
          break;
        }
      }
      double totalPrice = 0;
      for (var i = 0; i < state.carts.length; i++) {
        totalPrice += state.carts[i].price * state.carts[i].count;
      }
      emit(CartSuccess(totalPrice: totalPrice, carts: state.carts));
    });
    on<CartMinusEvent>((event, emit) {
      for (var i = 0; i < state.carts.length; i++) {
        if (state.carts[i].id == event.id) {
          if (state.carts[i].count > 1) {
            state.carts[i].count--;
          }
          break;
        }
      }
      double totalPrice = 0;
      for (var i = 0; i < state.carts.length; i++) {
        totalPrice += state.carts[i].price * state.carts[i].count;
      }
      emit(CartSuccess(totalPrice: totalPrice, carts: state.carts));
    });
    on<CartDeleteEvent>((event, emit) {
      for (var i = 0; i < state.carts.length; i++) {
        if (state.carts[i].id == event.id) {
          state.carts[i].count = 1;
          state.carts.removeAt(i);
          break;
        }
      }
      double totalPrice = 0;
      for (var i = 0; i < state.carts.length; i++) {
        totalPrice += state.carts[i].price * state.carts[i].count;
      }
      emit(CartSuccess(totalPrice: totalPrice, carts: state.carts));
    });
  }
}
