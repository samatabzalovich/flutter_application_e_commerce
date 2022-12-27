import 'package:flutter_application_e_commerce/controllers/cart_controller.dart';
import 'package:flutter_application_e_commerce/controllers/popular_product_controller.dart';
import 'package:flutter_application_e_commerce/controllers/recommended_product_controller.dart';
import 'package:flutter_application_e_commerce/data/api/api_client.dart';
import 'package:flutter_application_e_commerce/data/repository/cart_repo.dart';
import 'package:flutter_application_e_commerce/data/repository/popular_product_repo.dart';
import 'package:flutter_application_e_commerce/data/repository/recommende_product_repo.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
