import 'package:app/src/pages/common_widgets/custom_text_field.dart';
import 'package:app/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:app/src/config/app_data.dart' as appData;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/controller/auth_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {
               authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
            initialValue: authController.user.email,
            icon: Icons.email,
            label: 'Email',
            readOnly: true,
          ),

          //Nome
          CustomTextField(
            initialValue: authController.user.name,
            icon: Icons.person,
            label: 'Nome',
            readOnly: true,
          ),

          //Celular
          CustomTextField(
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: 'Celular',
            readOnly: true,
          ),

          //CPF
          CustomTextField(
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
            readOnly: true,
          ),

          //Botão para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {

    final newPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Título
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Senha atual
                      const CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      //Nova Senha
                      CustomTextField(
                        controller: newPasswordController,
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      //Nova Senha confirmar
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar nova senha',
                        isSecret: true,
                        validator: (password){
                          final result = passwordValidator(password);
                          if(result != null){
                            return result;
                          }
                          if(password != newPasswordController.text){
                            return 'As senhas não são equivalentes';
                          }
                          return null;
                        },
                      ),
                
                      //Botão de confirmação
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            _formKey.currentState!.validate();
                          },
                          child: const Text('Atualizar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              //Botão de fechar o dialog
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
