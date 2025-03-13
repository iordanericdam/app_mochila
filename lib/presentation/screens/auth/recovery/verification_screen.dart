import 'dart:math';

import 'package:app_mochila/presentation/screens/auth/recovery/new_password_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/api_service.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();

  void _reloadScreen(pin) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => VerificationScreen(email: widget.email)),
    );
  }

  Future<void> handlePasswordVerification(String email, String code) async {
    var response = await ApiService.verifyResetPasswordCode(email, code);
    if (response != null) {
      // Si la respuesta devuelta es válida, se pueden realizar algunos acciones
      print('Código de verificación correcto: ${response.toString()}');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewPasswordScreen(
                  email: widget.email,
                  code: pinController.text,
                )),
      );
    } else {
      print('Error en la verificación del código');
    }
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
            Text(
              "Hemos enviado un email a ${widget.email}, introudce el codigo de verificacion.",
              style: AppTextStyle.normal,
            ),
            sizedBox,
            sizedBox,
            SizedBox(
              width: 600,
              child: Pinput(
                controller: pinController,
                length: 5,
                //onCompleted: (pin) => _reloadScreen(pin),
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
                  handlePasswordVerification(widget.email, pinController.text);
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
