// ================= Category Header Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoryHeader extends StatelessWidget {
  const CategoryHeader(this._name, this._expected, this._inPractice, this._isCategoryOpen, this._toggleCategory, {Key? key}) : super(key: key);

  final String _name;
  final double _expected;
  final double _inPractice;
  final bool _isCategoryOpen;
  final VoidCallback _toggleCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Text(_name),
              Text(_expected.toString() + "/" + _inPractice.toString()),
              IconButton(
                onPressed: () => _toggleCategory(),
                icon: Icon(_isCategoryOpen ? gc.expandIcon : gc.minimizeIcon),
              )
            ],
          ),
          // TODO- add special progress widget
        ]
    );
  }
}
