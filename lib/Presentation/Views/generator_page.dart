import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_jcikwtux.json', width: 300, height: 300));
  }
}
