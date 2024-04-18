import 'package:flutter/material.dart';
import 'package:Remembrall/view/login_view.dart';
import '../models/item_model.dart';
import '../models/list_model.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingList> shoppingLists = [];
  String? selectedSearchResult;

  void addList(String listName) {
    if (listName.isNotEmpty &&
        !shoppingLists.any((list) => list.title == listName)) {
      setState(() {
        shoppingLists.add(ShoppingList(title: listName, items: []));
      });
    }
  }

  void addItemToList(String itemName, int quantity, int listIndex) {
    if (itemName.isNotEmpty && quantity > 0) {
      setState(() {
        shoppingLists[listIndex]
            .items
            .add(Item(name: itemName, quantity: quantity, isBought: false));
      });
    }
  }

  void removeItemFromList(int listIndex, int itemIndex) {
    setState(() {
      shoppingLists[listIndex].items.removeAt(itemIndex);
    });
  }

  void removeList(int listIndex) {
    setState(() {
      shoppingLists.removeAt(listIndex);
    });
  }

  void toggleItemBought(int listIndex, int itemIndex) {
    setState(() {
      shoppingLists[listIndex].items[itemIndex].isBought =
          !shoppingLists[listIndex].items[itemIndex].isBought;
    });
  }

  void editListTitle(int listIndex, String newTitle) {
    if (newTitle.isNotEmpty && newTitle != shoppingLists[listIndex].title) {
      setState(() {
        shoppingLists[listIndex].title = newTitle;
      });
    }
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
            icon: const Icon(Icons.exit_to_app),
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
          bool isSelected = shoppingLists[index].title == selectedSearchResult;
          return ExpansionTile(
            backgroundColor: isSelected ? Colors.yellow : null,
            title: Text(shoppingLists[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    final String? newTitle = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => EditListDialog(
                          initialText: shoppingLists[index].title),
                    );
                    if (newTitle != null) {
                      editListTitle(index, newTitle);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => removeList(index),
                ),
              ],
            ),
            children: shoppingLists[index].items.map((item) {
              bool isItemSelected = item.name == selectedSearchResult;
              return ListTile(
                tileColor: isItemSelected ? Colors.lightGreen : null,
                title: Text(
                  '${item.name} x${item.quantity}',
                  style: TextStyle(
                    decoration: item.isBought
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(item.isBought
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: () {
                    toggleItemBought(
                        index, shoppingLists[index].items.indexOf(item));
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final Map<String, dynamic>? newValues =
                            await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (BuildContext context) =>
                              EditItemDialog(item: item),
                        );
                        if (newValues != null) {
                          editItemDetails(
                              index,
                              shoppingLists[index].items.indexOf(item),
                              newValues['name'],
                              newValues['quantity']);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeItemFromList(
                          index, shoppingLists[index].items.indexOf(item)),
                    ),
                  ],
                ),
              );
            }).toList()
              ..add(ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Adicionar item'),
                onTap: () async {
                  final Map<String, dynamic>? newItem =
                      await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (BuildContext context) => AddItemDialog(),
                  );
                  if (newItem != null) {
                    addItemToList(newItem['name'], newItem['quantity'], index);
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

  void editItemDetails(
      int listIndex, int itemIndex, String newName, int newQuantity) {
    setState(() {
      Item item = shoppingLists[listIndex].items[itemIndex];
      item.name = newName;
      item.quantity = newQuantity;
    });
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
                  delegate: CustomSearchDelegate(
                    shoppingLists: shoppingLists,
                    searchInItems: false,
                    onSelected: (String result) {
                      setState(() {
                        selectedSearchResult = result;
                      });
                    },
                  ),
                );
              },
              child: const Text('Buscar por Lista'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    shoppingLists: shoppingLists,
                    searchInItems: true,
                    onSelected: (String result) {
                      setState(() {
                        selectedSearchResult = result;
                      });
                    },
                  ),
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
  final Function(String) onSelected;

  CustomSearchDelegate(
      {required this.shoppingLists,
      this.searchInItems = false,
      required this.onSelected});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
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
          (item) => item.name.toLowerCase().contains(query.toLowerCase()),
        ));
      }
    } else {
      matches.addAll(shoppingLists.where(
        (list) => list.title.toLowerCase().contains(query.toLowerCase()),
      ));
    }

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return ListTile(
          title: Text(searchInItems ? match.name : match.title),
          onTap: () {
            onSelected(searchInItems ? match.name : match.title);
            close(context, searchInItems ? match.name : match.title);
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

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nome do item'),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(hintText: 'Quantidade'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final String itemName = _nameController.text;
            final int itemQuantity =
                int.tryParse(_quantityController.text) ?? 0;
            if (itemName.isNotEmpty && itemQuantity > 0) {
              Navigator.of(context)
                  .pop({'name': itemName, 'quantity': itemQuantity});
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
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

class EditListDialog extends StatelessWidget {
  final String initialText;
  final TextEditingController _controller = TextEditingController();

  EditListDialog({Key? key, required this.initialText}) : super(key: key) {
    _controller.text = initialText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Lista'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Edite o nome da lista'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

class EditItemDialog extends StatefulWidget {
  final Item item;

  EditItemDialog({Key? key, required this.item}) : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nome do item'),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(hintText: 'Quantidade'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final String newName = _nameController.text;
            final int newQuantity =
                int.tryParse(_quantityController.text) ?? widget.item.quantity;
            if (newName.isNotEmpty && newQuantity > 0) {
              Navigator.of(context)
                  .pop({'name': newName, 'quantity': newQuantity});
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
