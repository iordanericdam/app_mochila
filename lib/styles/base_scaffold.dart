import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool showAppBar;

  const BaseScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backGroundLoginColor,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: showAppBar
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => {
                      Navigator.pop(context),
                      FocusScope.of(context).unfocus(),
                    },
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: ksmall, // Espaciado interno
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.black),
                    ),
                  ),
                )
              : null,
          body: body,
        ),
      ),
    );
  }
}
