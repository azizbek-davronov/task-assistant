import 'package:flutter/material.dart';

class HelperFunctions {
  static void scrollToBottom(ScrollController scrollController) {
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
