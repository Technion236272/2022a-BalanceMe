import 'package:balance_me/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AttachedImage extends StatefulWidget {
  const AttachedImage(this.imageUrl, this.transaction,{Key? key}) : super(key: key);
final String imageUrl;
final String transaction;

  @override
  _AttachedImageState createState() => _AttachedImageState();
}

class _AttachedImageState extends State<AttachedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MinorAppBar(widget.transaction),
        body: Image.network(widget.imageUrl));
  }
}
