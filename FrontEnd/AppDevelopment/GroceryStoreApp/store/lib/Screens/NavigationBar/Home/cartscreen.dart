import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'productdetail.dart';
import 'home.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final Function() onQuantityDecreased;
  final Function() onQuantityIncreased;
  final Function() onRemoveItem;

  const CartItemTile({
    Key? key,
    required this.cartItem,
    required this.onQuantityDecreased,
    required this.onQuantityIncreased,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.product.productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: Rs. ${cartItem.productInventory.price.toString()}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Quantity: ${cartItem.quantity}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF6FB457),
                      ),
                      child: IconButton(
                        onPressed: onQuantityDecreased,
                        icon: Icon(Icons.remove, color: Colors.white),
                        iconSize: 15,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF6FB457),
                      ),
                      child: IconButton(
                        onPressed: () {
                          onQuantityIncreased();
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        iconSize: 15,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      child: IconButton(
                        onPressed: onRemoveItem,
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        leading: Image.network(
          "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+cartItem.product.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: cartItem.product,
                productInventory: cartItem.productInventory,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Color(0xFF6FB457),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clearCart();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, _) {
                return ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    var cartItem = cartProvider.cartItems[index];
                    return CartItemTile(
                      cartItem: cartItem,
                      onQuantityDecreased: () {
                        if (cartItem.quantity > 1) {
                          cartProvider.decreaseQuantity(cartItem);
                        }
                      },
                      onQuantityIncreased: () {
                        cartProvider.increaseQuantity(cartItem);
                      },
                      onRemoveItem: () {
                        cartProvider.removeFromCart(cartItem);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Add logic to place order
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF6FB457),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


