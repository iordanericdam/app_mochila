import 'package:flutter/material.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/services/form_validator.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextEditingController? emailController;
  final FormFieldValidator<String>? validator;

  const PasswordInput({
    super.key,
    this.controller,
    this.hintText,
    this.emailController,
    this.validator,
  });

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      controller: widget.controller,
      hintText: widget.hintText ?? "",
      obscureText: !_passwordVisible, // Oculta o muestra la contraseña
      validator: widget.validator ?? validatePassword,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    );
  }
}
