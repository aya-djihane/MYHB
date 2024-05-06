//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rive/rive.dart';
//
// class SimpleAnimation extends StatelessWidget {
//   const SimpleAnimation({Key? key}) : super(key: key);
//
//   get RiveAnimation => null;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: const Text('Rive Animation'),
//       centerTitle: true,
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: RiveAnimation.network(
//               'https://public.rive.app/community/runtime-files/2191-4327-loader-solicitud-de-cuentas.riv',
//             ),
//           ),
//           Expanded(
//             child: RiveAnimation.asset(
//               'assets/Login.riv',
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// class StateMachineMuscot extends StatefulWidget {
//   const StateMachineMuscot({Key? key}) : super(key: key);
//
//   @override
//   _StateMachineMuscotState createState() => _StateMachineMuscotState();
// }
//
// class _StateMachineMuscotState extends State<StateMachineMuscot> {
//   Artboard? riveArtboard;
//   SMIBool? isDance;
//   SMITrigger? isLookUp;
//
//   @override
//   void initState() {
//     super.initState();
//     rootBundle.load('assets/Login.riv').then(
//           (data) async {
//         try {
//           final file = RiveFile.import(data);
//           final artboard = file.mainArtboard;
//           var controller =
//           StateMachineController.fromArtboard(artboard, 'idle');
//           if (controller != null) {
//             artboard.addController(controller);
//             isDance = controller.findSMI('hands_up');
//             isLookUp = controller.findSMI('fail');
//           }
//           setState(() => riveArtboard = artboard);
//         } catch (e) {
//           print(e);
//         }
//       },
//     );
//   }
//   void toggleDance(bool newValue) {
//     setState(() => isDance!.value = newValue);
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: const Text('Rive Animation'),
//       centerTitle: true,
//     ),
//     body: riveArtboard == null
//         ? const SizedBox()
//         : Column(
//       children: [
//         Expanded(
//           child: Rive(
//             artboard: riveArtboard!,
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text('hands up'),
//             Switch(
//               value: isDance!.value,
//               onChanged: (value) => toggleDance(value),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ElevatedButton(
//           child: const Text('fail'),
//           onPressed: () => isLookUp?.value = true,
//         ),
//         const SizedBox(height: 12),
//       ],
//     ),
//   );
// }