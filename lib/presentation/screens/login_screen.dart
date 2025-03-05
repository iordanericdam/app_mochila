import 'package:app_mochila/presentation/widgets/inputs.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Stack(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: kdefaultPadding),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: MediaQuery.of(context).size.height / 1.5,
                child: const Padding(
                  // Quitar
                  padding: kmedium,
                  child: Column(
                    children: [
                      CustomInput(
                        hintText: "Introduce tu email",
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
