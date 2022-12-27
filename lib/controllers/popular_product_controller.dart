import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/cart_controller.dart';
import 'package:flutter_application_e_commerce/data/repository/popular_product_repo.dart';
import 'package:flutter_application_e_commerce/models/cart_model.dart';
import 'package:flutter_application_e_commerce/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList {
    return _popularProductList;
  }

  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProduct() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).GetProducts);
      _isLoaded = true;
      update();
    } else {}
  }

  int get quantity {
    return _quantity;
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("item count", "You can't reduce more",
          backgroundColor: Colors.blue, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("item count", "You can't add more",
          backgroundColor: Colors.blue, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(Products product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    //if exist
    //get from storage _inCartItems
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(Products product) {
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }
  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
