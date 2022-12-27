import 'package:flutter/material.dart';
import 'package:flutter_application_e_commerce/utils/dimensions.dart';
import 'package:flutter_application_e_commerce/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  ExpandableTextWidget(this.text, {Key? key}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayedText = hiddenText ? (firstHalf + "...") : (firstHalf + secondHalf);
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(text: firstHalf, size: Dimensions.font16,)
            : Column(children: [
                SmallText(height: 1.8,color: Colors.black87,size: Dimensions.font16,
                    text: displayedText, overflow: TextOverflow.visible,),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: hiddenText ? "Show more" : "Show less",
                      color: Colors.blue,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: Colors.blue,
                    )
                  ]),
                )
              ]));
  }
}
