
import 'package:get/get.dart';
import 'package:khardel/models/orderItem.dart';

class AddToCartVM extends GetxController {
  List<OrderItem> lst = [];

  add(OrderItem orderItem) {
    lst.add(orderItem);
    update();
  }

  del(int index) {
    lst.removeAt(index);
    update();
  }
}
