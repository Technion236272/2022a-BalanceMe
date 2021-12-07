// ================= Category Header Widget =================
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:balance_me/global/utils.dart';
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
    double progressPercentage = getPercentage(_inPractice, _expected);

    return Column(
        children: [
          Row(
            children: [
              Text(_name),
              Text(_inPractice.toString() + "/" + _expected.toString()),  // TODO- add currency
              IconButton(
                onPressed: () => _toggleCategory(),
                icon: Icon(_isCategoryOpen ? gc.expandIcon : gc.minimizeIcon),
              )
            ],
          ),
          Padding(  // TODO- consider if Padding is necessary and put all constants in gc
            padding: const EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: progressPercentage,
              center: Text(progressPercentage.toString()),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: gc.primaryColor,
            ),
          ),
        ]
    );
  }
}
