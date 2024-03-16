class SearchResultsPage extends StatelessWidget {
  final List<Product> products;
  final List<ProductInventory> productInventories;
  final List<Vendor> vendors;

  const SearchResultsPage({
    Key? key,
    required this.products,
    required this.productInventories,
    required this.vendors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457), // Set AppBar background color to green
        title: Text('Search Results', textAlign: TextAlign.center),
        centerTitle: true, // Center align title
      ),
      body: ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, vendorIndex) {
          final vendor = vendors[vendorIndex];
          final vendorProducts = products.where((product) {
            final productInventory = productInventories.firstWhere(
                  (inventory) => inventory.productProductId == product.productId,
              orElse: () => ProductInventory(
                productInventoryId: -1, // Default value if product inventory not found
                price: 0,
                availableAmount: 0,
                listedAmount: 0,
                vendorVendorId: -1,
                productProductId: product.productId,
              ),
            );
            return productInventory.vendorVendorId == vendor.vendorId;
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  vendor.vendorName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.2, // Adjust the aspect ratio as needed
                ),
                itemCount: vendorProducts.length,
                itemBuilder: (context, productIndex) {
                  final product = vendorProducts[productIndex];
                  final productInventory = productInventories.firstWhere(
                        (inventory) => inventory.productProductId == product.productId,
                    orElse: () => ProductInventory(
                      productInventoryId: -1, // Default value if product inventory not found
                      price: 0,
                      availableAmount: 0,
                      listedAmount: 0,
                      vendorVendorId: -1,
                      productProductId: product.productId,
                    ),
                  );

                  return Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Price: \$${productInventory.price}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            product.productName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
