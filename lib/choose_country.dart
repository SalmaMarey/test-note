// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChooseCountry extends StatefulWidget {
//   const ChooseCountry({super.key});

//   @override
//   State<ChooseCountry> createState() => _ChooseCountryState();
// }

// class _ChooseCountryState extends State<ChooseCountry> {
//   savePref(String country) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setString('country', country);
//     print(preferences.getString('country'));
//   }

//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var country = preferences.getString('country');
//     if (country != null) {
//       Navigator.of(context).pushNamed('homepage');
//     }
//   }

//   @override
//   void initState() {
//     getPref();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: const Text(
//           'choose',
//         ),
//       ),
//       body: Container(
//         child: ListView(children: [
//           ListTile(
//             title: const Text('egypt'),
//             onTap: () {
//               savePref('egypt');
//             },
//           ),
//           ListTile(
//             title: const Text('china'),
//             onTap: () {
//               savePref('china');
//             },
//           ),
//           ListTile(
//             title: const Text('turkey'),
//             onTap: () {
//               savePref('turkey');
//             },
//           ),
//           ListTile(
//             title: const Text('france'),
//             onTap: () {
//               savePref('france');
//             },
//           ),
//           ListTile(
//             title: const Text('germany'),
//             onTap: () {
//               savePref('germany');
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
