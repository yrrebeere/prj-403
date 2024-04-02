SizedBox(height: 16.0),
Container(
height: 50,
padding: EdgeInsets.all(8.0),
decoration: BoxDecoration(
color: Color(0xFF6FB457),
borderRadius: BorderRadius.circular(8.0),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
IconButton(
icon: Icon(Icons.arrow_back_ios, size: 15,),color: Colors.white,
onPressed: () {
// Scroll the list to the left
_scrollController.animateTo(
_scrollController.offset - MediaQuery.of(context).size.width,
curve: Curves.linear,
duration: Duration(milliseconds: 500),
);
},
),
Text(
'History Based Recommendations',
style: TextStyle(fontSize: 20.0, color: Colors.white),
),
IconButton(
icon: Icon(Icons.arrow_forward_ios, size: 15,), color: Colors.white,
onPressed: () {
// Scroll the list to the right
_scrollController.animateTo(
_scrollController.offset + MediaQuery.of(context).size.width,
curve: Curves.linear,
duration: Duration(milliseconds: 500),
);
},
),
],
),
),
SizedBox(height: 8.0),
SingleChildScrollView(
scrollDirection: Axis.horizontal,
controller: _scrollController,
child: Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
_buildRecommendedProduct('Dalda Cooking Oil \n5Kg', 'Assets/Images/Products/dalda-oil.jpeg'),
_buildRecommendedProduct('Sunrise Wheat Flour \n10Kg', 'Assets/Images/Products/sunrise-flour.jpeg'),
_buildRecommendedProduct('Olpers Milk \n6 Pack', 'Assets/Images/Products/olpers-milk.jpg'),
_buildRecommendedProduct('Knorr Ketchup', 'Assets/Images/Products/knorr-ketchup.png'),
],
),
),


Widget _buildRecommendedProduct(String productName, String imagePath) {
return Container(
margin: EdgeInsets.only(right: 16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Image.asset(
imagePath,
width: 90,
height: 90,
fit: BoxFit.cover,
),
SizedBox(height: 8.0),
Center(
child: Text(
productName,
style: TextStyle(fontSize: 16.0),
),
),
],
),
);
}