import 'dart:convert';

import 'package:code_test/bloc/cart/cart_bloc.dart';
import 'package:code_test/models/cart_model.dart';
import 'package:code_test/pages/appbar_custom.dart';
import 'package:code_test/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_to_color/string_to_color.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<dynamic> carts = List.empty(growable: true);
  late List<dynamic> endData;
  late SharedPreferences sp;

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  readFromSp() {
    List<String>? cartListString = sp.getStringList('jsonData');
    if (cartListString != null) {
      carts = cartListString
          .map((contact) => CartModel.fromJson(json.decode(contact)))
          .toList();
    }
    for (var item in carts) {
      context.read<CartBloc>().add(CartAddEvent(item));
    }
    setState(() {});
  }

  saveIntoSp(jsonData) async {
    sp = await SharedPreferences.getInstance();
    List<dynamic> tempCarts = jsonData;
    List<String> cartListString =
        tempCarts.map((cart) => jsonEncode(cart.toJson())).toList();
    await sp.setStringList('jsonData', cartListString);
  }

  @override
  void initState() {
    getSharedPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartSuccess) {
          saveIntoSp(state.carts);
          return Container(
            height: 500,
            width: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Scaffold(
                // appBar: AppBar(
                //   leading: Image.asset(AppAssets.nike),
                //   title: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text(
                //         'Your Cart',
                //         style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                //       ),
                //       Text(
                //         ' \$${state.totalPrice.toStringAsFixed(2)}',
                //         style: const TextStyle(
                //             fontFamily: fontBoldApp, fontSize: 18),
                //       ),
                //     ],
                //   ),
                // ),
                appBar: customAppBar(
                    'Your Cart', ' \$${state.totalPrice.toStringAsFixed(2)}'),
                body: state.carts.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.carts.length,
                        itemBuilder: (context, index) {
                          var item = state.carts[index];
                          return itemWidget(item.id, item.imageUrl, item.name,
                              item.price, item.count, item.color);
                        },
                      )
                    : const Center(
                        child: Text('Your cart is empty',
                            style: TextStyle(
                                fontFamily: fontBoldApp, fontSize: 18)),
                      )),
          );
        } else if (state is CartFailed) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container(
            height: 500,
            width: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(color: Colors.white)),
            child: Scaffold(
                appBar: AppBar(
                  leading: Image.asset(AppAssets.nike),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Cart',
                        style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                      ),
                      Text(
                        ' \$0.00',
                        style: TextStyle(fontFamily: fontBoldApp, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                body: const Center(
                  child: Text('Your cart is empty',
                      style: TextStyle(fontFamily: fontBoldApp, fontSize: 18)),
                )),
          );
        }
      },
    );
  }

  Widget itemWidget(int id, String imageUrl, String name, double price,
      int count, String color) {
    Color color_convert = ColorUtils.stringToColor(color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                // backgroundImage: NetworkImage(imageUrl),
                backgroundColor: color_convert,
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(
                  -1.8 / 4,
                ),
                child: Image.network(imageUrl, height: 130, width: 130),
              ),
            ],
          ),
          const SizedBox(width: 18),
          SizedBox(
            height: 118,
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        const TextStyle(fontFamily: fontBoldApp, fontSize: 15)),
                Text(' \$${price.toString()}',
                    style:
                        const TextStyle(fontFamily: fontBoldApp, fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Image.network(AppAssets.minus),
                            onPressed: () {
                              if (count > 1) {
                                context
                                    .read<CartBloc>()
                                    .add(CartMinusEvent(id));
                              } else {
                                context
                                    .read<CartBloc>()
                                    .add(CartDeleteEvent(id));
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('$count'),
                        SizedBox(width: 10),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Image.network(AppAssets.plus),
                            onPressed: () {
                              context.read<CartBloc>().add(CartPlusEvent(id));
                            },
                          ),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.yellow,
                      child: IconButton(
                        icon: Image.network(AppAssets.trash),
                        onPressed: () {
                          context.read<CartBloc>().add(CartDeleteEvent(id));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
