import 'package:flutter_application_e_commerce/pages/food/popular_food_detail.dart';
import 'package:flutter_application_e_commerce/pages/food/recommended_food_detail.dart';
import 'package:flutter_application_e_commerce/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String _initial = '/';
  static const String _popularFood = "/popular-food";
  static const String _recommendedFood = "/recommended-food";
  static String getPopularFood(int pageId) => '$_popularFood?pageId=$pageId';
  static String getInitialPage() => '$_initial';
  static String getRecommendedPage(int index) => '$_recommendedFood?index=$index';
  static List<GetPage> routes = [
    GetPage(name: _initial, page: () => MainFoodPage()),
    GetPage(
        name: _popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(int.parse(pageId!),);
        }, transition: Transition.fadeIn),
    GetPage(
        name: _recommendedFood,
        page: () {
          var index = Get.parameters['index'];

          return RecommendedFoodDetail(int.parse(index!));
        }, transition: Transition.fadeIn),
  ];

}
