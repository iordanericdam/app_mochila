// import 'package:app_mochila/providers/backpack_notifier.dart';
// import 'package:app_mochila/providers/trip_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class BackpacksListScreen extends ConsumerWidget {
//   const BackpacksListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // TODO: implement build
//     final backpackState = ref.watch(tripNotifierProvider);
//     return Scaffold(
//       appBar: AppBar(title: Text("My backpacks")),
//       body: backpackState.when(
//           data: (backpacks) =>
//               ListView.builder(itemCount: backpacks.length, itemBuilder:(),
//           error: error,
//           loading: loading),
//     );
//   }
// }
