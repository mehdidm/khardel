
class Order {
  var id;
  var userId;
  List orderItems;
  String code;
  bool delivery;
  bool done;
  DateTime createdAt;
  DateTime deliveryDate;
  Order(
      {this.id,
      this.orderItems,
      this.code,
      this.delivery,
      this.done,
      this.userId,
        this.deliveryDate,
      this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "_id": id,
      "orderItems": orderItems,
      "delivery": delivery,
      "done": done,
      "code": code,
      "createdAt": createdAt.toIso8601String(),
      "deliveryDate":deliveryDate.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> item) {
    return Order(
        id: item['_id'],
        userId: item['userId'],
        delivery: item['delivery'],
        done: item['done'],
        code: item['code'],
        orderItems: item['orderItems'],
        createdAt:DateTime.parse(item['createdAt']),
      deliveryDate: DateTime.parse(item['deliveryDate'])
    );
  }



}
