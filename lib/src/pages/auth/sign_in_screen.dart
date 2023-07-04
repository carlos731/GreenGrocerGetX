import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/src/pages/auth/sign_up_screen.dart';
import 'package:app/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/base_screen.dart';
import '../../config/custom_colors.dart';
import '../common_widgets/app_name_widget.dart';
import '../common_widgets/custom_text_field.dart';
import 'controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  // Chave global do formulário.
  final _formKey = GlobalKey<FormState>();

  // Controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColors.customSwatchColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nome do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),

                    // Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText(
                              'Frutas',
                            ),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticíneos'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Formulário
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.isEmpty)
                            return 'Digite seu email!';

                          // Expressões regulares para verificar strings.
                          if (!email.isEmail) return 'Digite um email válido!';

                          return null;
                        },
                      ),

                      // Senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Digite seu email!";
                          }

                          if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres';
                          }

                          return null;
                        },
                      ),

                      // Botão de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(builder: (authController) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    // Navigator.of(context).pushReplacement(
                                    //   MaterialPageRoute(builder: (c) {
                                    //     return const BaseScreen();
                                    //   })
                                    // );
                                    FocusScope.of(context).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      print('Todos os campos estão válidos!');

                                      String email = emailController.text;
                                      String password = passwordController.text;

                                      print('Email: $email - Senha: $password');

                                      authController.signIn(
                                          email: email, password: password);
                                    } else {
                                      print('Campos não válidos!');
                                    }
                                    //Get.offNamed(PagesRoutes.baseRoute);
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          );
                        }),
                      ),

                      // Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),

                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green,
                              )),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (c) {
                            //       return SignUpScreen();
                            //     },
                            //   ),
                            // );
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text('Criar conta',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
