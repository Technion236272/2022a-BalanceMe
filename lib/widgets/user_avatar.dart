// ================= User Avatar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

class UserAvatar extends StatelessWidget {
  const UserAvatar(this._authRepository, this._radius);

  final AuthRepository _authRepository;
  final double _radius;

  @override
  Widget build(BuildContext context) {
    return _authRepository.avatarUrl != null ?
    CircleAvatar(
      backgroundImage: NetworkImage(_authRepository.avatarUrl!),
      radius: _radius,
      backgroundColor: Colors.transparent,
    )
    : Icon(
        gc.emptyAvatarIcon,
        size: _radius
    );
  }
}
