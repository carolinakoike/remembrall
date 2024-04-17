import 'package:Remembrall/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:Remembrall/models/list_model.dart';

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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchTypeSelect(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app), // Ícone de logout
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
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
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Adicionar uma nova lista'),
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
    );
  }

  void showSearchTypeSelect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecionar Tipo de Busca'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(shoppingLists: shoppingLists, searchInItems: false),
                );
              },
              child: const Text('Buscar por Lista'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(shoppingLists: shoppingLists, searchInItems: true),
                );
              },
              child: const Text('Buscar por Item'),
            ),
          ],
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String?> {
  final List<ShoppingList> shoppingLists;
  final bool searchInItems;

  CustomSearchDelegate({required this.shoppingLists, this.searchInItems = false});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matches = [];
    if (searchInItems) {
      for (var list in shoppingLists) {
        matches.addAll(list.items.where(
          (item) => item.toLowerCase().contains(query.toLowerCase()),
        ));
      }
    } else {
      matches.addAll(shoppingLists.where(
        (list) => list.title.toLowerCase().contains(query.toLowerCase()),
      ));
    }

    if (matches.isEmpty) {
      return Center(child: Text("Nenhuma correspondência encontrada."));
    }

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchInItems ? matches[index] : matches[index].title),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Editar"),
                content: TextField(
                  controller: TextEditingController(text: searchInItems ? matches[index] : matches[index].title),
                  decoration: const InputDecoration(hintText: 'Edite o texto aqui'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implementar lógica para salvar alterações aqui
                      Navigator.pop(context);
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            );
            close(context, null);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
