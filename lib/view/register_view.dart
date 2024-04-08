import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;
  final List<String> _genders = ['Masculino', 'Feminino', 'Outro'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Selecione sua data de nascimento',
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: const Color.fromARGB(255, 50, 33, 69), 
        foregroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.white), 
        actionsIconTheme: const IconThemeData(color: Colors.white), 
      ),
      backgroundColor: const Color.fromRGBO(212, 229, 237, 1.0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: false,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),],
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua data de nascimento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu e-mail';
                  }
                  String pattern = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres';
                  }                  
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'As senhas não correspondem';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _gender,
                items: _genders.map((String gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
                decoration: const InputDecoration(labelText: 'Sexo'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone Celular'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9()-]')),],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu telefone celular';
                  }                  
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  Expanded(
                    child: 
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cadastro realizado com sucesso!'),
                              duration: Duration(seconds: 5),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 5), () {
                            Navigator.of(context).pop(); 
                          });
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
                      child: const Text('Cadastrar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _nameController.clear();
                        _dobController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _confirmPasswordController.clear();
                        _phoneController.clear();
                        _gender = '';
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
            ],
          ),
        ),
      ),
    );
  }
}
