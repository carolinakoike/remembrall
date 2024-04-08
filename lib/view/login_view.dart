import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              'Lembrol',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
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
        backgroundColor: const Color.fromARGB(255, 50, 33, 69),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(212, 229, 237, 1.0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 2, 50, 80),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/login_screen.jpg',
                width: 300,
                height: 300,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white, 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um e-mail válido';
                  }
                  if (!value.contains('@')) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white, 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe uma senha válida';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login válido!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255, 50, 33, 69)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.purple[700];
                            }
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.purple[800];
                            }
                            return null;
                          },
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _emailController.clear();
                        _passwordController.clear();
                        _formKey.currentState!.reset();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255, 50, 33, 69)), 
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.purple[700];
                            }
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.purple[800];
                            }
                            return null;
                          },
                        ),
                      ),
                      child: const Text('Limpar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  _launchURL('https://accounts.google.com/signin');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 50, 33, 69)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.purple[700];
                      }
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.purple[800];
                      }
                      return null;
                    },
                  ),
                ),
                icon: const Icon(Icons.login),
                label: const Text('Login com Google'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/passwordRecovery');
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Não tenho cadastro, quero me cadastrar',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}