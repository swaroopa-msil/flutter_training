import 'package:march09/model/grocery_item.dart';

class GroceryData{
  static List<Map<String,String>> groceryDataList = [
    {
      "id": '1',
      "name": "Apples",
      "quantity": '3',
      "unit": "kg",
      "category": "Fruits",
      "price": '2.5',
      "url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJHB2LmJDE8mRo5vCggGcP-G5Jkov0nOYt700GGxzzQg&s"
    },
    {
      "id": '2',
      "name": "Milk",
      "quantity": '2',
      "unit": "liters",
      "category": "Dairy",
      "price": '1.2',
      "url":"https://www.thestatesman.com/wp-content/uploads/2018/08/milk.jpg"
    },
    {
      "id": '3',
      "name": "Bread",
      "quantity": '1',
      "unit": "loaf",
      "category": "Bakery",
      "price": '2.0',
      "url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOD2c8hZ8Vvj0g_SOe3f3xWnhsGGhk_5tjfQa2vG72Dw&s"
    },
    {
      "id": '4',
      "name": "Eggs",
      "quantity": '12',
      "unit": "pieces",
      "category": "Dairy",
      "price": '3.0',
      "url":"https://kidseatincolor.com/wp-content/uploads/2022/02/eggs-e1648216350119-500x500.jpeg"
    },
    {
      "id": '5',
      "name": "Tomatoes",
      "quantity": '0.5',
      "unit": "kg",
      "category": "Vegetables",
      "price": '1.0',
      "url":"https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/1200px-Tomato_je.jpg"
    }
  ];
  static List<GroceryItem> groceryWishList = [];
  static List<GroceryItem> groceryList = [];
}


