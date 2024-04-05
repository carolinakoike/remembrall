import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuaTelaDeLogin extends StatefulWidget {
  @override
  _SuaTelaDeLoginState createState() => _SuaTelaDeLoginState();
}

class _SuaTelaDeLoginState extends State<SuaTelaDeLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função para abrir URLs
  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Não foi possível abrir $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '"Esqueci Nunca Mais"',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              'Lista de Compras',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 176, 8, 170),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Seus outros widgets vão aqui...
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Aqui você pode adicionar a lógica para recuperar a senha
                  print('Esqueci minha senha');
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Aqui você pode adicionar a lógica para o cadastro
                  print('Não tenho cadastro, quero me cadastrar');
                },
                child: const Text(
                  'Não tenho cadastro, quero me cadastrar',
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Substitua pela sua URL de login do Google
                  _launchURL('https://accounts.google.com/signin');
                },
                icon: Icon(Icons.login),
                label: Text('Login com Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
