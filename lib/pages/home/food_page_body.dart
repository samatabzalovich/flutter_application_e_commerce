import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/controllers/popular_product_controller.dart';
import 'package:flutter_application_e_commerce/controllers/recommended_product_controller.dart';
import 'package:flutter_application_e_commerce/models/products_model.dart';
import 'package:flutter_application_e_commerce/pages/food/popular_food_detail.dart';
import 'package:flutter_application_e_commerce/routes/route_helper.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:flutter_application_e_commerce/utils/dimensions.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/icon_text_widget.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController _controller = PageController(viewportFraction: 0.85);

  var _curPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _curPageValue = _controller.page!;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPageItem(
      int index, BuildContext context, Products popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _curPageValue.floor()) {
      var currScale = 1 - (_curPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _curPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_curPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _curPageValue.floor() - 1) {
      var currScale = 1 - (_curPageValue - index) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
      ;
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {

              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: _height,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  image: DecorationImage(
                      image: AssetImage(
                          popularProduct.img!),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.textViewContainer,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: popularProduct.name!),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .color,
                                      size: Dimensions.width20,
                                    )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "4.5"),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "1287"),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "comments"),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            color: Colors.orange,
                            text: "Normal",
                            icon: Icons.circle_sharp,
                          ),
                          IconAndTextWidget(
                            color:
                                (Theme.of(context).textTheme.subtitle1!.color)!,
                            text: "1.7km",
                            icon: Icons.location_on,
                          ),
                          IconAndTextWidget(
                              color: Colors.red,
                              text: "37min",
                              icon: Icons.access_time_rounded),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    height: 320,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) => _buildPageItem(
                          position,
                          context,
                          popularProducts.popularProductList[position]),
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Colors.blue,
                  );
          },
        ),
        GetBuilder<PopularProductController>(
          builder: (popularProducts) => DotsIndicator(
            dotsCount: popularProducts.popularProductList.length <= 0
                ? 1
                : popularProducts.popularProductList.length,
            position: _curPageValue,
            decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: 'Recommended',
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: 'Food pairing'),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  itemCount: recommendedProduct.recommendeProductList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getRecommendedPage(index));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize - 10,
                                height: Dimensions.listViewImgSize - 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(recommendedProduct
                                            .recommendeProductList[index].img!),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.width10,
                                        right: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: recommendedProduct
                                              .recommendeProductList[index]
                                              .name!,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                'With chinese characteristics'),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(
                                              color: Colors.orange,
                                              text: "Normal",
                                              icon: Icons.circle_sharp,
                                            ),
                                            IconAndTextWidget(
                                              color: (Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .color)!,
                                              text: "1.7km",
                                              icon: Icons.location_on,
                                            ),
                                            IconAndTextWidget(
                                                color: Colors.red,
                                                text: "37min",
                                                icon:
                                                    Icons.access_time_rounded),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
              : const CircularProgressIndicator(
                  color: Colors.blue,
                );
        }),
      ],
    );
  }
}
