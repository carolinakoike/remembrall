import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo'),
        backgroundColor: const Color.fromARGB(255, 50, 33, 69),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lembrol, sua lista mágica de compras!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Versão 1.0.0',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição do Aplicativo:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Este aplicativo foi desenvolvido po Carolina Koike, baseado no item mágico da coleção do Mundo Mágico de Harry Potter, o Lembrol. O Lembrol é um artigo mágico, pouco maior que uma bola de golfe, que muda para a cor vermelha caso o possuidor esteja se esquecendo de alguma coisa. Assim como o Lembrol, esse aplicativo tem a finalidade de ajudar os usuários, através de suas listas, não esquecer de nenhum item em suas compras! Com ele, você pode adicionar, editar e remover itens de suas listas a qualquer momento.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
