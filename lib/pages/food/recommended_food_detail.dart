import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/popular_product_controller.dart';
import 'package:flutter_application_e_commerce/controllers/recommended_product_controller.dart';
import 'package:flutter_application_e_commerce/pages/cart/cart_page.dart';
import 'package:flutter_application_e_commerce/routes/route_helper.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:flutter_application_e_commerce/utils/dimensions.dart';
import 'package:flutter_application_e_commerce/widgets/app_icon.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int _index;
  const RecommendedFoodDetail(this._index);
  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendeProductList[_index];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitialPage());
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(
                    builder: (controller) => Stack(
                          children: [
                            GestureDetector(onTap: () => Get.to(CartPage()),child: AppIcon(icon: Icons.shopping_cart_outlined)),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: Colors.blue,
                                    ))
                                : Container(),
                                Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), size: 12, color: Colors.white,),
                                    ): Container()
                          ],
                        )),
              ],
            ),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.yellow,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                  text: product.name,
                  size: Dimensions.font26,
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: ExpandableTextWidget(product.description,
                  ),
                )
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) =>  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.setQuantity(false),
                    child:
                  AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: Colors.blue,
                    icon: Icons.remove,
                  )),
                  BigText(
                    text: "\$ ${product.price}  X  ${controller.inCartItems}",
                    color: Colors.black87,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: () => controller.setQuantity(true),
                    child: AppIcon(
                      iconSize: Dimensions.iconSize24,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue,
                      icon: Icons.add,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>controller.addItem(product),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.width20,
                        left: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.blue),
                      child:
                          BigText(text: "\$${product.price} | Add to cart", color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
