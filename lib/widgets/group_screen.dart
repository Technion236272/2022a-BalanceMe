import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/login_image.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required this.authRepository, required this.userStorage}) : super(key: key);
  final AuthRepository authRepository;
  final UserStorage userStorage;
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  Widget groupScreenHasGroup() {
    return Column(
        children: [
          LoginImage(),
          Text(widget.userStorage.userData!.groupName),
          Text(Languages.of(context)!.members),
          //TODO: request the group members from server
          Text(Languages.of(context)!.description),
          //TODO: get group description
          SizedBox(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        gc.leaveColor)),
                onPressed: () {
                  //TODO: set a leave group function
                },
                child: Text(Languages.of(context)!.leaveGroup)),
          )
        ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.groupScreenTitle),
      body: groupScreenHasGroup(),
    );
  }
}
