class OrderItem{
  var id;
  var userId;
  List supplements;
  int quantity;
  var food;
  String other;
  OrderItem({this.id,this.quantity,this.supplements,this.food,this.other,this.userId});


  Map<String, dynamic> toJson() {
    return {
      "userId":userId,
      "_id": id,
      "food":food,
      "supplements":supplements,
      "qte":quantity,
      "other":other,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> item) {
    return OrderItem(
      id: item['_id'],
      userId: item['userId'],
      food: item['food'],
      supplements: item['supplements'] as List,
      quantity: item['qte'],
      other: item['other'],
    );
  }
}