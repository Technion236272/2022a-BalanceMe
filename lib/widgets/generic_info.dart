// ================= Generic Info =================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericInfo extends StatelessWidget {
  const GenericInfo({this.title, this.topInfo, this.bottomInfo, Key? key}) : super(key: key);

  final String? title;
  final String? topInfo;
  final String? bottomInfo;

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
            children: [title == null ? Container()
                : Text(
                  title!,
                  style: const TextStyle(fontSize: gc.infoTitleFontSize),
                ),
              topInfo == null ? Container()
                  : Padding(
                    padding: gc.innerColumnPadding,
                    child: Text(
                      topInfo!,
                      style: const TextStyle(fontSize: gc.infoFontSize),
                    ),
                  ),
              bottomInfo == null ? Container()
                  : Text(
                    bottomInfo!,
                    style: const TextStyle(fontSize: gc.infoFontSize),
                  ),],
          ),
        ),
      ),
    );
  }
}
