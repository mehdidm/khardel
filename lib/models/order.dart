class Order {
  var id;
  var userId;
  List orderItems;
  String code;
  bool delivery;
  bool done;
  Order(
      {this.id,
      this.orderItems,
      this.code,
      this.delivery,
      this.done,
      this.userId});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "_id": id,
      "orderItems": orderItems,
      "delivery": delivery,
      "done": done,
      "code": code
    };
  }

  factory Order.fromJson(Map<String, dynamic> item) {
    return Order(
        id: item['_id'],
        userId: item['userId'],
        delivery: item['delivery'],
        done: item['done'],
        code: item['code'],
        orderItems: item['orderItems']);
  }
}
