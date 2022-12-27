import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/cart_controller.dart';
import 'package:flutter_application_e_commerce/routes/route_helper.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:flutter_application_e_commerce/utils/dimensions.dart';
import 'package:flutter_application_e_commerce/widgets/app_icon.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blue,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getInitialPage()),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.blue,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: Colors.blue,
                  iconSize: Dimensions.iconSize24,
                )
              ],
            )),
        Positioned(
          top: Dimensions.height20 * 5,
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height15),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GetBuilder<CartController>(
                builder: (cartController) => ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (context, index) => Container(
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.height20 * 5,
                                height: Dimensions.height20 * 5,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage( cartController.getItems[index].img!),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Expanded(
                                  child: Container(
                                height: Dimensions.height20 * 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text:
                                          cartController.getItems[index].name!,
                                      color: Colors.black54,
                                    ),
                                    SmallText(
                                      text: "Spicy",
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text:
                                              "\$ ${cartController.getItems[index].price}",
                                          color: Colors.redAccent,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: Dimensions.height10,
                                            bottom: Dimensions.height10,
                                            right: Dimensions.width10,
                                            left: Dimensions.width10,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white),
                                          child: Row(children: [
                                            GestureDetector(
                                                onTap: () {
                                                  // cartController
                                                  //     .setQuantity(false);
                                                },
                                                child: Icon(Icons.remove,
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            BigText(
                                              text: '0'
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10 / 2,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  // popularProduct
                                                  //     .setQuantity(true);
                                                },
                                                child: Icon(Icons.add,
                                                    color: Colors.grey)),
                                          ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
