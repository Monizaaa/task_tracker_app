import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomerLoading extends StatelessWidget {
  const CustomerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [Color(0xFFFED883), Color(0xFFC6C3FB), Color(0xFFFEB5BD)],
          strokeWidth: 3,
        ),
      ),
    );
  }
}
