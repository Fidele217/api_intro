import 'package:flutter/material.dart';


class BaseAppBar extends AppBar {
  
  final String titlePage;

  static String smallTitle(String title) {
    return title.substring(0, title.length > 15 ? 15 : title.length)
          + (title.length > 15 ? "..." : "");
  }

  BaseAppBar({ Key? key, required this.titlePage, required BuildContext context }) : super(key: key, 
    backgroundColor:  Colors.purpleAccent,
      title: Wrap(
        children: [
          Text(smallTitle(titlePage))
        ],
      ),
  );
}