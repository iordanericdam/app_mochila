import 'package:app_mochila/styles/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/presentation/widgets/widgetsHome/custom_home_appbar.dart';

class HomeScaffold extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final bool showAppBar;

  const HomeScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Oculta el teclado al tocar fuera de los campos
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: showAppBar
            ? const PreferredSize(
                preferredSize: Size.fromHeight(160),
                child: CustomHomeAppbar(),
              )
            : null,
        drawer: const MenuDrawer(),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}