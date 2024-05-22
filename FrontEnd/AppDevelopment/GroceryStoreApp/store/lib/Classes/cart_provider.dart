import 'package:flutter/cupertino.dart';
import 'package:store/Classes/product.dart';
import 'package:store/Classes/product_inventory.dart';

import 'cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product, ProductInventory productInventory, int quantity) {
    _cartItems.add(CartItem(product: product, productInventory: productInventory, quantity: quantity,));
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    int index = cartItems.indexOf(cartItem);
    cartItems[index].quantity--;
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}