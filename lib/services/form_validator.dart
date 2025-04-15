import 'package:app_mochila/services/register.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController functionMessageText(
    BuildContext context, Text messageContent, Color backgroundColor) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: messageContent,
    backgroundColor: backgroundColor,
  ));
}

String? genericValidator(String? value, int length) {
  if (value == null || value.isEmpty) {
    return 'Este campo es obligatorio';
  } else if (value.length < length) {
    return 'Este campo debe tener al menos $length caracteres';
  }
  return null;
}

String? telefonoValidator(String? value, int length) {
  if (value == null || value.isEmpty) {
    return null;
  } else if (value.length < length) {
    return 'El número debe tener al menos $length dígitos';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Solo se permiten números';
  }
  return null;
}

String? emailValidator(String? value) {
  RegExp regExp = RegExp(emailPattern);
  if (value == null || value.isEmpty) {
    return "El campo esta vacio";
  } else if (!regExp.hasMatch(value)) {
    return "El formato de correo electronico no es valido";
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese la contraseña';
  }
  if (value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  if (!regex.hasMatch(value)) {
    return 'La contraseña no contiene ningun carácter especial';
  }
  return null;
}

String? validatePasswordCustom(String? value, String? value2) {
  if (genericValidator(value2, 5) != null) {
    return null;
  }

  if (value!.isEmpty) {
    return 'Por favor ingrese la contraseña';
  }
  if (value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  return null;
}

String? validateConfirmPassword(
    String? value, TextEditingController passwordController1) {
  if (validatePassword(passwordController1.text) != null) {
    return null;
  }
  if (value == null || value.isEmpty) {
    return 'La contraseña no puede estar vacía';
  } else if (value != passwordController1.text) {
    return 'Las contraseñas no coinciden';
  }
  return null;
}

String? validateStartDate(DateTime? startDate) {
  if (startDate == null) {
    return 'La fecha de inicio es obligatoria';
  }
  return null;
}

String? validateSelectedWeather(String? weather) {
  if (weather == null || weather.isEmpty) {
    return 'Selecciona un tipo de clima';
  }
  return null;
}

String? validateCategories(List<String> categories) {
  if (categories.isEmpty) {
    return 'Selecciona al menos una categoría';
  }
  return null;
}

String? validateDestino(String? value) {
  if (value == null || value.isEmpty) {
    return 'El destino es obligatorio';
  }
  return null;
}
