part of 'cart_bloc.dart';

abstract class CartState {
  List<dynamic> carts = [];
  CartState({required this.carts});
}

class CartInitial extends CartState {
  CartInitial({required super.carts});
}

class CartLoading extends CartState {
  CartLoading({required super.carts});
}

class CartSuccess extends CartState {
  double totalPrice;
  CartSuccess({required this.totalPrice, required super.carts});
}

class CartFailed extends CartState {
  final String message;

  CartFailed({required this.message, required super.carts});
}
