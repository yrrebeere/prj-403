import 'package:store/Classes/product.dart';
import 'package:store/Classes/product_inventory.dart';

class CartItem {
  Product product;
  ProductInventory productInventory;
  int _quantity;

  CartItem({
    required this.product,
    required this.productInventory,
    required int quantity,
  }) : _quantity = quantity;

  int get quantity => _quantity;
  set quantity(int value) {
    _quantity = value;
  }
}