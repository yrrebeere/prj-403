import 'package:flutter/material.dart';
class page4 extends StatelessWidget {
  final String phoneNumber;
  final String password;

  const page4({Key? key, required this.phoneNumber, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone Number: $phoneNumber'),
            Text('Password: $password'),
          ],
        ),
      ),
    );
  }
}
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFF6FB457),
//           elevation: 0,
//         ),
//         body: SafeArea(
//         ),
//       ),
//     );
//   }
// }
