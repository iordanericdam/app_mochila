import 'dart:math';

import 'package:app_mochila/presentation/screens/new_password_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();
  void _reloadScreen(pin) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const VerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: WhiteBaseContainer(
      child: Align(
        alignment: Alignment.topLeft,
        child: Form(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Revisa tu correo",
              style: AppTextStyle.title,
            ),
            sizedBox,
            const Text(
              "Hemos enviado un email a email@email.com, introudce el codigo de verificacion.",
              style: AppTextStyle.normal,
            ),
            sizedBox,
            sizedBox,
            SizedBox(
              width: 600,
              child: Pinput(
                controller: pinController,
                length: 5,
                onCompleted: (pin) => _reloadScreen(pin),
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            sizedBox,
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: CustomElevatedButton(
                text: 'Comprobar codigo',
                backgroundColor: AppColors.recoverButtonColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewPasswordScreen()),
                  );
                },
              ),
            ),
            kHalfSizedBox,
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                   //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "¿No has recibido el email?",
                      style: AppTextStyle.normal,
                    ),
                    TextButton(onPressed: () {}, child: const Text("Reenviar"))
                  ],
                ))
          ],
        )),
      ),
    ));
  }
}
