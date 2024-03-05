part of 'cart_bloc.dart';

abstract class CartEvent {}

class CartAddEvent extends CartEvent {
  final dynamic cartModel;
  CartAddEvent(this.cartModel);
}

class CartPlusEvent extends CartEvent {
  final int id;
  CartPlusEvent(this.id);
}

class CartMinusEvent extends CartEvent {
  final int id;
  CartMinusEvent(this.id);
}

class CartDeleteEvent extends CartEvent {
  final int id;
  CartDeleteEvent(this.id);
}
