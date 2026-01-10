// loading_message.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

class LoadingMessage extends StatelessWidget {
  final String message;
  final String animationAsset;
  final double animationHeight;

   const LoadingMessage({
    super.key,
    this.message = "loading",
    this.animationAsset = 'assets/animations/circle.json',
    this.animationHeight = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animationAsset, height: animationHeight),
          const SizedBox(height: 6),
          Text(
            message.tr(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
