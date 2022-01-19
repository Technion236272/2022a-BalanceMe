import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class AddCategoryButton extends StatelessWidget {
  AddCategoryButton(this._isIncome, {Key? key}) : super(key: key);
  final bool _isIncome;

  void _openAddCategory(BuildContext context) {
    navigateToPage(context, SetCategory(DetailsPageMode.Add, _isIncome), AppPages.SetCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<UserStorage>(context, listen: false).currentDate != null,
      child: Padding(
        padding: gc.addCategoryButtonPadding,
        child: SizedBox(
          width: gc.addCategoryButtonWidth,
          height: gc.addCategoryButtonHeight,
          child: ElevatedButton(
              onPressed: () {_openAddCategory(context);},
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
      ),
    );
  }
}
