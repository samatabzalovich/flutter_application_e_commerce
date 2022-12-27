import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/cart_controller.dart';
import 'package:flutter_application_e_commerce/controllers/popular_product_controller.dart';
import 'package:flutter_application_e_commerce/pages/cart/cart_page.dart';
import 'package:flutter_application_e_commerce/routes/route_helper.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:flutter_application_e_commerce/utils/dimensions.dart';
import 'package:flutter_application_e_commerce/widgets/app_column.dart';
import 'package:flutter_application_e_commerce/widgets/app_icon.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int _pageId;
  PopularFoodDetail(this._pageId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[_pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('${product.img}')),
                ),
              )),
          Positioned(
            left: 20,
            right: 20,
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getInitialPage()),
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(
                    builder: (controller) => Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () => Get.to(CartPage()),
                                      child: AppIcon(
                                        icon: Icons.circle,
                                        size: 20,
                                        iconColor: Colors.transparent,
                                        backgroundColor: Colors.blue,
                                      ),
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
          ),
          Positioned(
            right: 0,
            left: 0,
            top: Dimensions.popularFoodImgSize,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(product.name),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Introduce"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableTextWidget(product.description))),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) => Container(
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
                child: Row(children: [
                  GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: Colors.grey)),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(
                    text: popularProduct.inCartItems.toString(),
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: Colors.grey)),
                ]),
              ),
              GestureDetector(
                  onTap: () => popularProduct.addItem(product),

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
                  child: BigText(
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
