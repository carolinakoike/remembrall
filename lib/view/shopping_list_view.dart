import 'package:flutter/material.dart';
import 'package:Remembrall/models/list_model.dart';  // Certifique-se que este modelo está definido corretamente
import 'package:Remembrall/models/item_model.dart';  // Certifique-se que este modelo está definido corretamente
import 'user_information_view.dart';  // Ajuste para o caminho correto se necessário

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingList> shoppingLists = [];

  void addList(String listName) {
    if (listName.isNotEmpty && !shoppingLists.any((list) => list.title == listName)) {
      setState(() {
        shoppingLists.add(ShoppingList(title: listName, items: []));
      });
    }
  }

  void addItemToList(String item, int listIndex) {
    if (item.isNotEmpty) {
      setState(() {
        shoppingLists[listIndex].items.add(item);
      });
    }
  }

  void removeItemFromList(int listIndex, int itemIndex) {
    setState(() {
      shoppingLists[listIndex].items.removeAt(itemIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de Compras'),
        backgroundColor: const Color.fromARGB(255, 50, 33, 69),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final String? listName = await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AddListDialog(),
              );
              if (listName != null) {
                addList(listName);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(shoppingLists[index].title),
            children: shoppingLists[index].items.map((item) => ListTile(
              title: Text(item),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeItemFromList(index, shoppingLists[index].items.indexOf(item)),
              ),
            )).toList()
            ..add(ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Adicionar item'),
              onTap: () async {
                final String? newItem = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AddItemDialog(),
                );
                if (newItem != null) {
                  addItemToList(newItem, index);
                }
              },
            )),
          );
        },
      ),
    );
  }
}

class AddListDialog extends StatefulWidget {
  @override
  _AddListDialogState createState() => _AddListDialogState();
}

class _AddListDialogState extends State<AddListDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova Lista'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Nome da Lista',
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Adicionar'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Item'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Nome do item'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context). pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context). pop(_controller.text),
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
