import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Classes/api.dart';
import '../../../Classes/cart_item.dart';
import '../../../Classes/cart_provider.dart';
import '../../../Classes/order_details.dart';
import '../../../Classes/orders.dart';
import 'productdetail.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1, // Limit the number of lines to 2
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
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
                      Text(
                        'Total Price: Rs. ${cartItem.productInventory.price * cartItem.quantity}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
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
                    SizedBox(width: 5),
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
                    SizedBox(width: 5),
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
          "${ApiConstants.baseUrl}/api/image/"+cartItem.product.image,
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

  Future<void> placeOrder(BuildContext context, List<CartItem> cartItems) async {
    Orders order = Orders(
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now().add(Duration(days: 7)),
      totalBill: calculateTotalBill(cartItems),
      orderStatus: 'In Process',
      groceryStoreId: 2,
      vendorId: 7,
    );

    final orderResponse = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/order/addorder'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    if (orderResponse.statusCode == 200) {

      final orderJson = jsonDecode(orderResponse.body);
      int orderId = orderJson['order_id'];

      List<OrderDetails> orderDetails = [];
      cartItems.forEach((cartItem) {
        orderDetails.add(OrderDetails(
          quantity: cartItem.quantity,
          unitPrice: cartItem.productInventory.price,
          totalPrice: cartItem.quantity * cartItem.productInventory.price,
          orderId: orderId,
          productInventoryId: cartItem.productInventory.productInventoryId,
        ));
      });

      for (var orderDetail in orderDetails) {
        print(jsonEncode(orderDetail.toJson()));
        await http.post(
          Uri.parse('${ApiConstants.baseUrl}/api/order_detail/addorderdetail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(orderDetail.toJson()),
        );
      }

      Navigator.pop(context);

    } else {
      throw Exception('Failed to place order');
    }
  }

  int calculateTotalBill(List<CartItem> cartItems) {
    int total = 0;
    cartItems.forEach((cartItem) {
      total += cartItem.quantity * cartItem.productInventory.price;
    });
    return total;
  }

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
            child: Column(
              children: [
                Text(
                  'Total Bill: Rs. ${calculateTotalBill(Provider.of<CartProvider>(context, listen: false).cartItems)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await placeOrder(context, Provider.of<CartProvider>(context, listen: false).cartItems);
                    Provider.of<CartProvider>(context, listen: false).clearCart();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}


