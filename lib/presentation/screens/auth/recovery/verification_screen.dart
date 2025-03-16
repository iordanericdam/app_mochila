import 'package:app_mochila/presentation/screens/auth/recovery/new_password_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/reset_password.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();

  // void _reloadScreen(pin) {
  Future<void> handlePasswordVerification(String email, String code) async {
    var response = await ResetPassword.verifyResetPasswordCode(email, code);
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
            // Text(
            //   "Si la cuenta existe, en la bandeja de entrada de  $email habra recibido un codigo, introducelo a continuacion.",
            //   style: AppTextStyle.normal,
            // ),
            RichText(
              text: TextSpan(
                text: "Hemos enviado un codigo de verificacion a ",
                style: AppTextStyle.normal,
                children: [
                  TextSpan(
                    text: widget.email,
                    style: AppTextStyle.normalBold,
                  ),
                  const TextSpan(
                    text: ". Por favor, introducelo a continuacion:",
                    style: AppTextStyle.normal,
                  ),
                ],
              ),
            ),
            sizedBox,
            sizedBox,
            SizedBox(
              width: double.infinity,
              child: Pinput(
                separatorBuilder: (index) => const SizedBox(width: 10),
                controller: pinController,
                length: 5,
                onCompleted: (pin) => {
                  handlePasswordVerification(widget.email, pin),
                },
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
                onPressed: () {},
              ),
            ),
            sizedBox,
            Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                  text: "No has recibido el codigo? ",
                  style: AppTextStyle.normal,
                  children: [
                    TextSpan(
                      text: "Reenviar",
                      style: AppTextStyle.normalBold,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Implementar logica de reenvio de correo
                        },
                    ),
                  ],
                )))
          ],
        )),
      ),
    ));
  }
}
