// ================= Profile settings page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/balance.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'appbar.dart';
import 'bottom_navigation.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings(
      {Key? key, required this.authRepository, required this.userStorage})
      : super(key: key);
  final AuthRepository authRepository;
  final UserStorage userStorage;

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();

  Widget pencilButton(VoidCallback? onPressed) {
    return IconButton(onPressed: onPressed, icon:
    const Icon(gc.editPencil, color: gc.alternativePrimary,),
    );
  }





  Widget getProfileScreen() {
    return Scaffold(

      appBar: MinorAppBar(Languages.of(context)!.profileSettings + ' ' +
          Languages.of(context)!.settings),
      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAvatar(widget.authRepository, gc.profileAvatarRadius),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      gc.padAroundPencil, gc.padProfileAvatar,
                      gc.padAroundPencil, gc.padAroundPencil),
                  child: pencilButton(() async {await updateAvatar();}),
                ),
              ]),
          TextBox(controllerFirstName, null, labelText: getFirstName()
            , haveBorder: false, suffix: pencilButton(() {
              updateFirstName(controllerFirstName.text);
            }),),
          TextBox(controllerLastName, null, labelText: getLastName(),
            haveBorder: false,
            suffix: pencilButton(() {
              updateLastName(controllerLastName.text);
            }),),
        ],
      ),
    );
  }

  Widget getFirstName() {
    if (widget.authRepository.isAuthenticated &&
        widget.userStorage.userData != null
        && widget.userStorage.userData!.firstName != null) {
      return Text(widget.userStorage.userData!.firstName!);
    }
    else {
      return Text(Languages.of(context)!.firstName);
    }
  }

  Widget getLastName() {
    if (widget.authRepository.isAuthenticated &&
        widget.userStorage.userData != null
        && widget.userStorage.userData!.lastName != null) {
      return Text(widget.userStorage.userData!.lastName!);
    }
    else {
      return Text(Languages.of(context)!.lastName);
    }
  }

  void updateFirstName(String firstName) {
    widget.userStorage.setFirstName(firstName);
    widget.userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.profileChangeSuccessful);
  }

  void updateLastName(String lastName) {
    widget.userStorage.setLastName(lastName);
    widget.userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.profileChangeSuccessful);
  }

  Future<void> updateAvatar()
  async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage=await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage==null)
      {
        displaySnackBar(context, Languages.of(context)!.noImagePicked);
      }
    else
      {
       widget.authRepository.uploadAvatar(pickedImage);
      }
  }

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getProfileScreen();
  }
}
