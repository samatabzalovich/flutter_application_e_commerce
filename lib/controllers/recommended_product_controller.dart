import 'package:flutter_application_e_commerce/data/repository/popular_product_repo.dart';
import 'package:flutter_application_e_commerce/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommende_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendeProductList {
    return _recommendedProductList;
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProduct() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Product.fromJson(response.body).GetProducts);
      _isLoaded = true;
      update();
    } else {}
  }
}
