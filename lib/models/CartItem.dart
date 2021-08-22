import 'package:khardel/models/orderItem.dart';

class CartItem{

  OrderItem orderItem;
  String foodTitle;
  String foodPrice;
  String foodPoints;

  CartItem({this.orderItem,this.foodPoints,this.foodPrice,this.foodTitle});


}