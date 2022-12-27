import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/pages/home/food_page_body.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(top: 45, bottom: 15),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                Column(
                  children:  [
                    BigText(text: 'Bangladesh', color: Colors.blue),
                    Row(
                      children: [
                        SmallText(text: 'Narsingdi'),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    child: const Icon(Icons.search, color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: Colors.blue),
                  ),
                )
              ]),
            ),
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody()))
        ],
      ),
    );
  }
}
