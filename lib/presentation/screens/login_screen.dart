import 'package:app_mochila/presentation/screens/forgot_password_screen.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/styles/app_text_style.dart';
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
    return SafeArea(
      child: BaseScaffold(
        showAppBar: false,
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: kdefaultPadding),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
                  ),
                )),
            Expanded(
              flex: 7,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Padding(
                    // Quitar
                    padding: kmedium,
                    child: Column(
                      children: [
                        kHalfSizedBox,
                        const Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.heroTitle,
                        ),
                        kHalfSizedBox,
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text:
                                'Inicio de sesión ', // Texto con estilo normal
                            style: AppTextStyle.normal,
                            children: [
                              TextSpan(
                                  text: 'NombreApp',
                                  style: AppTextStyle.normalBold),
                            ],
                          ),
                        ),
                        // Text(
                        //   'Inicio de sesión NombreApp',
                        //   style: AppTextStyle.title,
                        //   textAlign: TextAlign.center,
                        // ),
                        sizedBox,
                        const Text(
                          'Email',
                          style: AppTextStyle.title,
                          textAlign: TextAlign.left,
                        ),
                        const CustomInput(
                          hintText: "Introduce tu email",
                        ),
                        sizedBox,
                        const Text(
                          'Password',
                          style: AppTextStyle.title,
                          textAlign: TextAlign.left,
                        ),
                        const PasswordInput(),
                        TextButton(
                          child: const Text('¿Contraseña olvidada?'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                        ),
                        TextButton(
                          child: const Text('¿Nuevo usuario?'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
