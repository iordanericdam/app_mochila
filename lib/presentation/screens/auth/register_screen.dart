import 'package:app_mochila/models/User.dart';
import 'package:app_mochila/presentation/screens/auth/login_screen.dart';
import 'package:app_mochila/presentation/widgets/button_login.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/password_custom_input.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/services/register.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nombreController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  Future<void> _register(String email, String password, String name) async {
    FocusScope.of(context).unfocus();
    print('Registrando usuario...');
    // Llamar al servicio de API para realizar el inicio de sesión
    var response = await Register.register(email, password, name);

    if (response != null && response.containsKey("user")) {
      print(
          'Usuario registrado: ${response["user"]}'); // Verifica si "user" está en la respuesta

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Registrado correctamente'),
            backgroundColor: Colors.green),
      );

      //REDIRECCIÓN
      Future.delayed(const Duration(seconds: 1), () {
        print("Redirigiendo al Login...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error en el registro'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _registerKey,
        child: Padding(
          padding: klarge,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      "Registro",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    sizedBox,
                    Text(
                      "Rellena los siguientes campos",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        'Email',
                        style: AppTextStyle.normalBoldWhite,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    CustomInput(
                      controller: _emailController,
                      hintText: '',
                      validator: (value) {
                        return emailValidator(value);
                      },
                    ),
                    sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        'Nombre',
                        style: AppTextStyle.normalBoldWhite,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    CustomInput(
                      controller: _nombreController,
                      validator: (value) {
                        int length = 4;
                        return genericValidator(value, length);
                      },
                    ),
                    sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        'Password',
                        style: AppTextStyle.normalBoldWhite,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    PasswordInput(
                      controller: _passwordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        'Confirma la contraseña',
                        style: AppTextStyle.normalBoldWhite,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    PasswordInput(
                      controller: _passwordConfirmController,
                      validator: (value) {
                        return validateConfirmPassword(
                            value, _passwordController);
                      },
                    ),
                    sizedBox,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButtonLogin(
                        text: 'Registrarse',
                        gradient: AppColors.loginButtonColor,
                        onPressed: () {
                          if (_registerKey.currentState!.validate()) {
                            _register(
                                _emailController.text,
                                _passwordController.text,
                                _nombreController.text);
                          }
                        },
                      ),
                    ),
                    kHalfSizedBox,
                    Align(
                        alignment: Alignment.center, child: _buildLoginText()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildLoginText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "¿Ya tienes cuenta? ",
        style: const TextStyle(color: Colors.black, fontSize: 14),
        children: [
          TextSpan(
            text: "Inicia sesión",
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
          ),
        ],
      ),
    );
  }
}
