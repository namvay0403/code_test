import 'package:code_test/bloc/cart/cart_bloc.dart';
import 'package:code_test/pages/screen1.dart';
import 'package:code_test/pages/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_data_bloc/get_data_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDataBloc(),
      child: BlocProvider(
        create: (context) => CartBloc(),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 40,
              runSpacing: 30,
              children: [
                Screen1(),
                Screen2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
