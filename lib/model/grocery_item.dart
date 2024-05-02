

class GroceryItem{
  final String id;
  final String title;
  final String quantity;
  final String url;
  final String price;
  final String category;
  final String units;
  bool isWishListed;

  GroceryItem({
    required this.title,
    required this.id,
    required this.category,
    required this.price,
    required this.quantity,
    required this.url,
  required this.units,
  }):isWishListed = false;


}