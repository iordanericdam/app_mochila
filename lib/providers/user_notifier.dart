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
      // 处理请求失败的情况
      state = AsyncError(e, st);
    }
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  return UserNotifier();
});
