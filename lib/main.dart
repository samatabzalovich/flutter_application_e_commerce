import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/popular_product_controller.dart';
import 'package:flutter_application_e_commerce/controllers/recommended_product_controller.dart';
import 'package:flutter_application_e_commerce/pages/home/main_food_page.dart';
import 'package:flutter_application_e_commerce/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProduct();
    Get.find<RecommendedProductController>().getRecommendedProduct();
    return GetMaterialApp(
      home: MainFoodPage(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: const TextStyle(color: Colors.blue),
              )),
      initialRoute: RouteHelper.getInitialPage(),
      getPages: RouteHelper.routes,
    );
  }
}
