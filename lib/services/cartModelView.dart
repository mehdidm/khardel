
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

  getTotalPrice(){
    double  total=0.0;
    for(int i=0;i<lst.length;i++){
      // ignore: unnecessary_statements
      total=total+(double.parse(lst[i].foodPrice)*lst[i].orderItem.quantity);
    }
    return total;
    //update();
  }

  getTotalPoints(){
    int  totalPoints=0;

    for(int i=0;i<lst.length;i++){
      totalPoints=totalPoints+(int.parse(lst[i].foodPoints)*lst[i].orderItem.quantity);
    }
    return totalPoints;
    //update();
  }
}
