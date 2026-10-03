import 'package:flutter/material.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';

class GodBrothersServiceScreen extends StatelessWidget {
  const GodBrothersServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('GodBrothersServiceScreen',
        style: MyTextStyles.textStyle16Bold,),
      ),
    );
  }
}
