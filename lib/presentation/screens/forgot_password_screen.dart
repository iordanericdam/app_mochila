import 'package:app_mochila/presentation/screens/verification_screen.dart';
import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/services/form_validator.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _resetPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: WhiteBaseContainer(
      child: Align(
        alignment: Alignment.topLeft,
        child: Form(
          key: _resetPasswordKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recuperar contraseña",
                style: AppTextStyle.title,
              ),
              sizedBox,
              const Text("Introduce tu email para poder cambiar la contraseña",
                  style: AppTextStyle.normal),
              sizedBox,
              CustomInput(
                  hintText: "Introduce tu email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return emailValidator(value);
                  }),
              kHalfSizedBox,
              SizedBox(
                height: kdefaultPadding * 2,
                width: MediaQuery.of(context).size.width,
                child: CustomElevatedButton(
                  text: 'Buscar cuenta',
                  backgroundColor: AppColors.recoverButtonColor,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_resetPasswordKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificationScreen()),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
