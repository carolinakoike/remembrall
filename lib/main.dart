import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'view/login_view.dart';
import 'view/password_recovery_view.dart'; 

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      // home: LoginView(), // Use LoginView aqui
//     );
//   }
// }


      useInheritedMediaQuery: true, // Adicione esta linha
      locale: DevicePreview.locale(context), // Adicione esta linha
      builder: DevicePreview.appBuilder, // Adicione esta linha
      // Define as rotas nomeadas
      routes: {
        '/': (context) => LoginView(), // Define a rota inicial
        '/passwordRecovery': (context) => PasswordRecoveryView(), // Adiciona a rota para a recuperação de senha
      },
    );
  }
}
