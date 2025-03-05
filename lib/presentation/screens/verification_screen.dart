import 'package:app_mochila/presentation/screens/new_password_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/verificationCodeWidget.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  void _reloadScreen() {
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            sizedBox,
            const Text(
              "Hemos enviado un email a email@email.com, introudce el codigo de verificacion.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            sizedBox,
            sizedBox,
            VerificationCodeField(
              fieldCount: 6,
              fieldSize: const Size(40, 30),
              onFinished: (String numericCode) {
                _reloadScreen();
              },
              // ios: _counter.isOdd, // Opción para iOS cuando el contador es impar
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
                        builder: (context) => NewPasswordScreen()),
                  );
                },
              ),
            )
          ],
        )),
      ),
    ));
  }
}
