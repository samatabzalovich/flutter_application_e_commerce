import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/widgets/big_text.dart';
import 'package:flutter_application_e_commerce/widgets/icon_text_widget.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';

import '../utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
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
                        color: Theme.of(context).textTheme.subtitle1!.color,
                        size: 20,
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
          height: Dimensions.height20,
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
              color: (Theme.of(context).textTheme.subtitle1!.color)!,
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
    );
  }
}
