import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String title;
  const Headline1(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
