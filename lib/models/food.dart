import 'package:khardel/models/category.dart';

class Food {
  var id;
  String title;
  String description;
  String price;
  bool available;
  var category;
  String points;

  Food(
      {this.id,
      this.description,
      this.category,
      this.title,
      this.available,
      this.points,
      this.price});

  Map<String, dynamic> toJson() {
    return {
      //"_id": id,
      "description": description,
      "title": title,
      "points": points,
      "price":price,
      "available":available,
      "category":category,
    };
  }

  factory Food.fromJson(Map<String, dynamic> item) {
    return Food(
      id: item['_id'],
      title: item['title'],
      description: item['description'],
      price: item['price'],
      points: item['points'] ,
      available: item['available'],
      category: item['category']
    );
  }
}
