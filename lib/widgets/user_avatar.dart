// ================= User Avatar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;
class UserAvatar extends StatefulWidget {
  const UserAvatar(this._authRepository, this._radius,
      {Key? key, this.proportion})
      : super(key: key);

  final AuthRepository _authRepository;
  final double _radius;
  final double? proportion;

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
                  child:
                  Image.network(
                widget._authRepository.avatarUrl!,
                fit: BoxFit.cover,
                width: widget.proportion ?? widget._radius,
                height: widget.proportion ?? widget._radius,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return CircularProgressIndicator();
                },
              )),
            ),
          )
        : const Icon(gc.emptyAvatarIcon,
            size: gc.settingDefaultAppbarAvatarSize);
  }
}
