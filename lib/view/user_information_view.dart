import 'package:flutter/material.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Usuário'),
        backgroundColor: const Color.fromARGB(255, 50, 33, 69),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nome do Usuário: Nome Exemplo', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('E-mail: exemplo@dominio.com', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Retorna à tela anterior
              },
              child: const Text('Voltar'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 50, 33, 69),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
