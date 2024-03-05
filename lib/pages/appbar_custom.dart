import 'package:code_test/utilities/constant.dart';
import 'package:flutter/material.dart';

PreferredSize customAppBar(String title, String totalPrice) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssets.nike, height: 40, width: 40),
          totalPrice.isEmpty
              ? Text(
                  title,
                  style: const TextStyle(fontFamily: fontBoldApp, fontSize: 20),
                )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontFamily: fontBoldApp, fontSize: 20),
                    ),
                    Text(
                        totalPrice,
                        style: const TextStyle(
                            fontFamily: fontBoldApp, fontSize: 18),
                      ),
                  ],
                ),
        ],
      ),
    ),
  );
}
