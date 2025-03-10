import 'package:app_mochila/presentation/screens/auth/recovery/forgot_password_screen.dart';
import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/styles/app_colors.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final double logoAreaHeight = 220;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseScaffold(
        showAppBar: false,
        body: Stack(
          children: [
            //PARTE SUPERIOR FIJADA CON POSITIONED CON LOGO
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: logoAreaHeight,
              child: Center(
                child: Image.asset('assets/images/logo.png',
                    height: MediaQuery.of(context).size.height / 5),
              ),
            ),
            // PARTE INFERIOR CON EL FORMU. POSITIONED
            Positioned.fill(
              top: logoAreaHeight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: kmedium,
                child: SingleChildScrollView(
                  padding: kmedium,
                  child: Column(
                    //UNICAMENTE CREAMOS UNA COLUMNA PARA LA PARTE INFERIOR-> LE DECIMOS QUE SE ALINEE AL PRINCIPIO Croos.start, SI NOS INTERESALUEGO ENVOLVEMOS DENTRO DE UN CENTER lo que nos interesa. El resto queda alineado a la izquierda
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.heroTitle,
                            ),
                            kHalfSizedBox,
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                text: 'Inicio de sesión ',
                                style: AppTextStyle.normal,
                                children: [
                                  TextSpan(
                                      text: 'NombreApp',
                                      style: AppTextStyle.normalBold),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kdefaultPadding * 1.5),
                      const Padding(
                        padding: kleftPadding,
                        child: Text(
                          'Email',
                          style: AppTextStyle.title,
                        ),
                      ),
                      kHalfSizedBox,
                      CustomInput(
                          hintText: "Introduce tu email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return emailValidator(value);
                          }),
                      sizedBox,
                      const Padding(
                        padding: kleftPadding,
                        child: Text(
                          'Password',
                          style: AppTextStyle.title,
                        ),
                      ),
                      kHalfSizedBox,
                      const PasswordInput(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text(
                            '¿Contraseña olvidada?',
                            style: AppTextStyle.buttonTextNormal,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                        ),
                      ),
                      sizedBox,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomButtonLogin(
                          text: 'Inicia sesión',
                          gradient: AppColors.loginButtonColor,
                          onPressed: () {
                            // LOGICA DE CREDENCIALES Y NAVEGACION AL HOME O WELCOME.
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: RichText(
                            text: const TextSpan(
                              text: '¿No tienes cuenta?',
                              style: AppTextStyle.buttonTextNormal,
                              children: [
                                TextSpan(
                                    text: ' Regístrate',
                                    style: AppTextStyle.buttonTextBold),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                        ),
                      ),
                    ],
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
