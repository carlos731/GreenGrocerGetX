// import 'package:flutter/material.dart';

// import '../config/custom_colors.dart';
// import 'components/custom_text_field.dart';

// class SignUpScreen2 extends StatelessWidget {
//   const SignUpScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.customSwatchColor,
//       body: Column(
//         children: [
//           const Expanded(
//             child: Center(
//               child: Text('Cadastro',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 35,
//                   )),
//             ),
//           ),

//           //Formulário
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 32,
//               vertical: 40,
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(45),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                const CustomTextField(
//                   icon: Icons.email,
//                   label: 'Email',
//                 ),
//                const CustomTextField(
//                   icon: Icons.lock,
//                   label: 'Senha',
//                   isSecret: true,
//                 ),
//                const CustomTextField(
//                   icon: Icons.person,
//                   label: 'Nome',
//                 ),
//                const CustomTextField(
//                   icon: Icons.phone,
//                   label: 'Celular',
//                 ),
//                const CustomTextField(
//                   icon: Icons.file_copy,
//                   label: 'CPF',
//                 ),

//                 //Botão de cadastrar usuário
//                 SizedBox(
//                   height: 50,
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: const Text('Cadastrar usuário', 
//                     style: TextStyle(
//                       fontSize: 18,
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
