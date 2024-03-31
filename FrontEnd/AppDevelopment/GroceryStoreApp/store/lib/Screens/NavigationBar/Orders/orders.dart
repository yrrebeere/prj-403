import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'currentorders.dart';
import 'orderhistory.dart';

class SearchProductInventory {
  final int productId;
  final String name;
  final String imageUrl;

  SearchProductInventory({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  factory SearchProductInventory.fromJson(Map<String, dynamic> json) {
    return SearchProductInventory(
      productId: json['product_id'],
      name: json['product_name'],
      imageUrl: json['image'],
    );
  }
}

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<SearchProductInventory> searchResults = [];
  TextEditingController searchController = TextEditingController();

  // Hardcoded vendorId as 1
  int vendorId = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedButton(
            label: AppLocalizations.of(context)!.curr_orders,
            icon: Icons.local_shipping,
            color: Color(0xFF6FB457),
            onPressed: () {
              // Navigate to the page for current orders
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrentOrdersPage(vendorId),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          AnimatedButton(
            label: AppLocalizations.of(context)!.order_history,
            icon: Icons.history,
            color: Colors.blue,
            onPressed: () {
              // Navigate to the page for order history
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistory(vendorId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Function onPressed;

  const AnimatedButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          _controller.forward();
        },
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
