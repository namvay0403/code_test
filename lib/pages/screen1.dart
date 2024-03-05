import 'package:code_test/bloc/get_data_bloc/get_data_bloc.dart';
import 'package:code_test/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_to_color/string_to_color.dart';

import '../bloc/cart/cart_bloc.dart';
import '../models/cart_model.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetDataBloc>().add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white)),
      child: Scaffold(
          appBar: AppBar(
            leading: Image.asset(AppAssets.nike),
            title: const Text(
              'Our Products',
              style: TextStyle(fontFamily: fontBoldApp, fontSize: 20),
            ),
          ),
          body: BlocBuilder<GetDataBloc, GetDataState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.shoes.length,
                itemBuilder: (context, index) {
                  var shoe = state.shoes[index];
                  return item(
                      id: shoe.id,
                      imageUrl: shoe.image,
                      name: shoe.name,
                      description: shoe.description,
                      price: shoe.price,
                      color: shoe.color);
                },
              );
            },
          )),
    );
  }

  Widget item(
      {required int id,
      required String imageUrl,
      required String name,
      required String description,
      required double price,
      required String color}) {
    Color color_convert = ColorUtils.stringToColor(color);
    bool check = false;
    CartModel cartModel = CartModel(id, 1, price, name, imageUrl, color);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartSuccess) {
          check = context.read<CartBloc>().checkCart(id);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   height: 380,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(18),
              //     color: color_convert,
              //     image: DecorationImage(
              //         image: NetworkImage(imageUrl), fit: BoxFit.cover),
              //   ),
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 380,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: color_convert,
                      // image: DecorationImage(
                      //     image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      -1.8 / 4,
                    ),
                    child: Image.network(imageUrl),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(name,
                  style:
                      const TextStyle(fontSize: 18, fontFamily: fontBoldApp)),
              const SizedBox(height: 15),
              Text(description,
                  style: const TextStyle(
                      fontSize: 15, fontFamily: fontApp, color: Colors.grey)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' \$$price',
                      style: const TextStyle(
                          fontSize: 18, fontFamily: fontBoldApp)),
                  InkWell(
                      onTap: () {
                        context.read<CartBloc>().add((CartAddEvent(cartModel)));
                      },
                      child: check == false
                          ? Container(
                              height: 40,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.yellow,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'ADD TO CART',
                                    style: TextStyle(
                                        fontFamily: fontBoldApp, fontSize: 15),
                                  ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                icon: Image.asset(AppAssets.check),
                                onPressed: () {},
                              ),
                            ))
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
