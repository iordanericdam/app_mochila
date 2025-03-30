import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class WhiteBaseContainer extends StatelessWidget {
  final Widget child;

  const WhiteBaseContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: kDefaultPadding),
        height: double.infinity,
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: whiteThing(),
        child: Padding(
          padding: kmedium,
          child: child,
        ));
  }
}
