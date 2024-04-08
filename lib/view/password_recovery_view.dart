import 'package:flutter/material.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key}); 
  @override
  PasswordRecoveryViewState createState() => PasswordRecoveryViewState(); 
}

class PasswordRecoveryViewState extends State<PasswordRecoveryView> { 
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperação de Senha'), 
        backgroundColor: const Color.fromARGB(255, 50, 33, 69), 
        foregroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.white), 
        actionsIconTheme: const IconThemeData(color: Colors.white), 
      ),
      backgroundColor: const Color.fromRGBO(212, 229, 237, 1.0), 
      body: Padding(
        padding: const EdgeInsets.fromLTRB(45, 5, 45, 150), 
        child: Form(
          key: _formKey, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/gifs/throwing.gif',
                width: 310,
                height: 310,              
              ),
              const SizedBox(height: 20), 
              const Text( 
                'Insira seu e-mail para recuperar a senha:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20), 
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration( 
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white, 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o e-mail.';
                  }
                  String pattern = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Link de recuperação enviado para ${_emailController.text}'),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(context).pop(); 
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 50, 33, 69)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) return Colors.purple[700]; 
                      if (states.contains(MaterialState.pressed)) return Colors.purple[800];
                      return null;
                    },
                  ),
                ),
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
