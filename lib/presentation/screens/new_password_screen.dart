import 'package:app_mochila/presentation/screens/eric_explicacion.dart';
import 'package:app_mochila/presentation/screens/login_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
              "Nueva contraseña",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            sizedBox,
            const Text(
              "Solo un paso más! Introduce la nueva contraseña y vualeve a disfrutar de tus mochilas.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            sizedBox,
            const PasswordInput(),
            kHalfSizedBox,
            const PasswordInput(
              hintText: "Repite la contraseña",
            ),
            sizedBox,
            SizedBox(
              height: kdefaultPadding * 2,
              width: MediaQuery.of(context).size.width,
              child: CustomElevatedButton(
                text: 'Actualizar contraseña',
                backgroundColor: AppColors.recoverButtonColor,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            )
          ],
        )),
      )),
    );
  }
}
