import 'package:flutter/material.dart';

class InventoryItem {
  final String name;
  final int availableQty;
  final int listedQty;
  final int unitCost;
  final String imageUrl;

  InventoryItem({
    required this.name,
    required this.availableQty,
    required this.listedQty,
    required this.unitCost,
    required this.imageUrl,
  });
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  Future<void> _handleProductSelection(InventoryItem selectedProduct) async {
    Navigator.pop(context, selectedProduct);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6FB457),
          title: Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Text('WASAIL'),
          ),
          elevation: 0,
          leading: IconButton(
            icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Store List',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String itemName = 'Product $index';
                    final InventoryItem product = InventoryItem(
                      name: itemName,
                      availableQty: 50 + index * 10,
                      listedQty: 30 + index * 5,
                      unitCost: 10 + index * 2,
                      imageUrl: 'https://example.com/image_$index.png',
                    );
                    return ListTile(
                      title: Text(itemName),
                      subtitle: Text(
                        'Available Qty: ${product.availableQty}, Listed Qty: ${product.listedQty}, Unit Cost: ${product.unitCost}',
                      ),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await _handleProductSelection(product);
                        },
                        child: Text('Add'),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final List<InventoryItem> inventoryItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xfff2f2f6),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            '${inventoryItems.length} Listed SKUs',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: inventoryItems.length,
                      itemBuilder: (context, index) {
                        InventoryItem item = inventoryItems[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openItemDetails(item);
                              },
                              child: Container(
                                height: 160,
                                width: 370,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(50),
                                                border: Border.all(color: Colors.black, width: 1.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                                            ),
                                            Text('Available Qty: ${item.availableQty}', style: TextStyle(color: Color(0xFF007AFF))),
                                            Text('Listed Qty: ${item.listedQty}', style: TextStyle(color: Color(0xFF007AFF))),
                                            Text('Unit Cost: ${item.unitCost}', style: TextStyle(color: Color(0xFF6FB457))),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0),
                                            child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchBarApp()),
          );

          if (result != null && result is InventoryItem) {
            setState(() {
              inventoryItems.add(result);
            });
          }
        },
        backgroundColor: Color(0xFF6FB457),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openItemDetails(InventoryItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(
          item: item,
          onDelete: () {
            setState(() {
              inventoryItems.remove(item);
            });
          },
        ),
      ),
    );
  }
}

class ItemDetailsPage extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onDelete;

  const ItemDetailsPage({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title:Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text('WASAIL'),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 650,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        image: DecorationImage(
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        onDelete();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Delete Item'),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Qty: ${item.availableQty}', style: TextStyle(color: Color(0xFF007AFF))),
                        Text('Listed Qty: ${item.listedQty}', style: TextStyle(color: Color(0xFF007AFF))),
                        Text('Unit Cost: ${item.unitCost}', style: TextStyle(color: Color(0xFF6FB457))),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



