import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/connection_lost_page.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class AddCategoryButton extends StatefulWidget {
  const AddCategoryButton({Key? key}) : super(key: key);

  @override
  _AddCategoryButtonState createState() => _AddCategoryButtonState();
}

class _AddCategoryButtonState extends State<AddCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: gc.addCategoryButtonPadding,
      child: SizedBox(
        width: gc.addCategoryButtonWidth,
        height: gc.addCategoryButtonHeight,
        child: ElevatedButton(
            onPressed: () {
              //TODO - implement Logic
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(gc.addCategoryButtonRadius),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(gc.addIcon),
                Text(Languages.of(context)!.strAddCategory),
              ],
            )),
      ),
    );
  }
}
