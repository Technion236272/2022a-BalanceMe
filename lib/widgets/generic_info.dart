// ================= Generic Info =================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericInfo extends StatelessWidget {
  const GenericInfo(this._title, this._topInfo, this._bottomInfo, {Key? key}) : super(key: key);

  final String? _title;
  final String? _topInfo;
  final String? _bottomInfo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - gc.generalInfoWidthCorrection,
        height: gc.generalInfoHeight,
        decoration: BoxDecoration(
          color: gc.backgroundDesignColor,
          borderRadius: BorderRadius.circular(gc.cardBorderRadius),
        ),
        child: Padding(
          padding: gc.outerColumnPadding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_title == null ? Container()
                : Text(
                  _title!,
                  style: const TextStyle(fontSize: gc.infoTitleFontSize),
                ),
              _topInfo == null ? Container()
                  : Padding(
                    padding: gc.innerColumnPadding,
                    child: Text(
                      _topInfo!,
                      style: const TextStyle(fontSize: gc.infoFontSize),
                    ),
                  ),
              _bottomInfo == null ? Container()
                  : Text(
                    _bottomInfo!,
                    style: const TextStyle(fontSize: gc.infoFontSize),
                  ),],
          ),
        ),
      ),
    );
  }
}
