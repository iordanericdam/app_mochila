import 'package:app_mochila/presentation/screens/auth/login_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/api_service.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  const NewPasswordScreen({super.key, required this.email, required this.code});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  // final pinController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  Future<void> handlePasswordReset(
      String email, String code, String newPassword) async {
    FocusScope.of(context).unfocus();
    var response = await ApiService.resetPassword(email, code, newPassword);

    if (response != null) {
      print('Contraseña restablecida correctamente: ${response.toString()}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      print('Error en el restablecimiento de la contraseña');
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
              "Nueva contraseña",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            sizedBox,
            const Text(
              "Solo un paso más! Introduce la nueva contraseña y vualeve a disfrutar de tus mochilas.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            sizedBox,
            PasswordInput(
              controller: passwordController,
              validator: (value) {
                validatePassword(value);
              },
            ),
            kHalfSizedBox,
            PasswordInput(
              hintText: "Repite la contraseña",
              controller: confirmPwController,
              validator: (value) {
                validateConfirmPassword(value, passwordController);
              },
            ),
            sizedBox,
            SizedBox(
              height: kdefaultPadding * 2,
              width: MediaQuery.of(context).size.width,
              child: CustomElevatedButton(
                text: 'Actualizar contraseña',
                backgroundColor: AppColors.recoverButtonColor,
                onPressed: () {
                  handlePasswordReset(
                      widget.email, widget.code, passwordController.text);
                },
              ),
            )
          ],
        )),
      )),
    );
  }
}
