import 'dart:io';

import 'package:app_mochila/models/User.dart';
import 'package:app_mochila/services/api/UserApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  UserNotifier() : super(const AsyncValue.loading());

  Future<void> login(Map<String, dynamic> userData) async {
    try {
      final user = await UserApi().login(userData);
      state = AsyncData(user!);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      return await UserApi().register(userData);
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> registerWithPhoto(
      Map<String, dynamic> userData, File? imageFile) async {
    print(userData);
    final user = await UserApi()
        .registerWithPhoto(userData: userData, imageFile: imageFile);
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendRegisterCode(Map<String, dynamic> data) async {
    return await UserApi().sendRegisterCode(data);
  }

  Future<bool> vertifierRegisterCode(String email, String code) async {
    return await UserApi()
        .vertifierRegisterCode({"email": email, "code": code});
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  return UserNotifier();
});
