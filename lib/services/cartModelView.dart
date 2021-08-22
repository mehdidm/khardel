
import 'package:get/get.dart';
import 'package:khardel/models/CartItem.dart';
import 'package:khardel/models/orderItem.dart';

class AddToCartVM extends GetxController {
  List<CartItem> lst = [];

  add(CartItem cartItem) {
    lst.add(cartItem);
    update();
  }

  del(int index) {
    lst.removeAt(index);
    update();
  }
}
