import 'dart:io';

import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 引入 Riverpod
import 'package:pinput/pinput.dart';

class RegisterScreen4 extends ConsumerStatefulWidget {
  final String email;
  final String password;
  final String usuario;
  final String nombre;
  final String telefono;
  final File? imagen;

  const RegisterScreen4(
      {super.key,
      required this.email,
      required this.password,
      required this.usuario,
      required this.nombre,
      required this.telefono,
      this.imagen});

  @override
  ConsumerState<RegisterScreen4> createState() => _RegisterScreen4State();
}

class _RegisterScreen4State extends ConsumerState<RegisterScreen4> {
  final pinController = TextEditingController();
  bool hasPinError = false;
  String? pinErrorText;
  final _registerKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ref
        .read(userNotifierProvider.notifier)
        .sendRegisterCode({"email": widget.email});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WhiteBaseContainer(
        child: Align(
          alignment: Alignment.topLeft,
          child: Form(
            key: _registerKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Revisa tu correo",
                  style: AppTextStyle.title,
                ),
                sizedBox,
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
                    onCompleted: (pin) => handlePasswordVerification(
                      widget.email,
                      widget.password,
                      widget.nombre,
                      widget.usuario,
                      widget.telefono,
                      pin,
                    ),
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    errorPinTheme: hasPinError
                        ? PinTheme(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        : null,
                  ),
                ),
                if (hasPinError && pinErrorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                    child: Text(
                      pinErrorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                sizedBox,
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: CustomElevatedButton(
                    text: 'Comprobar codigo',
                    backgroundColor: AppColors.recoverButtonColor,
                    onPressed: () {
                      handlePasswordVerification(
                        widget.email,
                        widget.password,
                        widget.nombre,
                        widget.usuario,
                        widget.telefono,
                        pinController.text,
                      );
                    },
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
                              // 实现重新发送验证码的逻辑
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handlePasswordVerification(String email, String password,
      String username, String name, String phone, String pin) async {
    bool success = await ref
        .read(userNotifierProvider.notifier)
        .vertifierRegisterCode(email, pin);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correcto.')),
      );

      await ref.read(userNotifierProvider.notifier).registerWithPhoto({
        "email": email,
        "username": username,
        "password": password,
        "phone": phone,
        "name": name
      }, widget.imagen);
    } else {
      setState(() {
        hasPinError = true;
        pinErrorText = 'Código incorrecto. Intenta de nuevo.';
      });
    }
  }

  Future<bool> sendRegisterCode2(String email) async {
    return await ref
        .read(userNotifierProvider.notifier)
        .sendRegisterCode({"email": email});
  }
}
