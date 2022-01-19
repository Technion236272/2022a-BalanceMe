// ================= User Avatar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

class UserAvatar extends StatefulWidget {
  const UserAvatar(this._authRepository, this._radius, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final double _radius;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}
class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return widget._authRepository.avatarUrl != null
        ? Padding(
            padding: gc.settingAppbarAvatarPadding,
            child: CircleAvatar(
              radius: widget._radius,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                  child: FadeInImage.assetNetwork(
                      height: widget._radius,
                      width: widget._radius,
                      fit: BoxFit.cover,
                      placeholder: gc.load,
                      image: widget._authRepository.avatarUrl!
                  ),
              ),
            ),
          )
        : Icon(gc.emptyAvatarIcon, size: widget._radius);
  }
}
