import 'package:app_mochila/presentation/screens/auth/recovery/forgot_password_screen.dart';
import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/providers/trip_notifier.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/UserApi.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final double logoAreaHeight = 220;
  final _loginKey = GlobalKey<FormState>();

// Future indica que la función es asíncrona y que el resultado estará disponible en el futuro.
// async (asíncrono) Cuando declaramos una función con async, indicamos que la función puede realizar operaciones asíncronas.
// await (esperar) Se usa dentro de una función async. Hace que la ejecución espere hasta que la operación asíncrona se complete antes de continuar
//
  Future<void> _login(String email, String password) async {
    FocusScope.of(context).unfocus();
    await ref
        .read(userNotifierProvider.notifier)
        .login({"email": email, "password": password});
    ref.invalidate(tripNotifierProvider);
    //print('Email: $email, Password: $password');
    // Llamar al servicio de API para realizar el inicio de sesión
    var user = await UserApi().login({"email": email, "password": password});
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Error en el login. El mail o la contraseña no coinciden')));
    } else {
      print("Usuario logueado: $user");

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Bienvenido, ${user.name}!',
            style: const TextStyle(fontSize: 16),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushNamed(context, '/tripForm');
    }
  }

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
              child: Form(
                key: _loginKey,
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
                            controller: emailController,
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
                        PasswordInput(
                          hintText: 'Introduce tu contraseña',
                          controller: passwordController,
                          validator: (value) {
                            return validatePassword(value);
                          },
                        ),
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
                              if (_loginKey.currentState!.validate()) {
                                // Si el formulario es válido, llamamos a la función de inicio de sesión
                                // con los valores de los controladores de texto
                                _login(emailController.text,
                                    passwordController.text);
                              }
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
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ),
                        Center(
                          child: TextButton(
                            child: const Text("SETUP VIAJE DIRECTO"),
                            onPressed: () {
                              Navigator.pushNamed(context, '/setupBpTrip');
                            },
                          ),
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
