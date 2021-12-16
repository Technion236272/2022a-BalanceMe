// ================= Profile settings page =================
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'appbar.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();

  Widget pencilButton(GestureTapCallback? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        gc.editPencil,
        color: gc.alternativePrimary,
      ),
    );
  }

  Widget getFirstName() {
    if (widget.authRepository.isAuthenticated &&
        widget.userStorage.userData != null &&
        widget.userStorage.userData!.firstName != null) {
      return Text(widget.userStorage.userData!.firstName!);
    } else {
      return Text(Languages.of(context)!.firstName);
    }
  }

  Widget getLastName() {
    if (widget.authRepository.isAuthenticated &&
        widget.userStorage.userData != null &&
        widget.userStorage.userData!.lastName != null) {
      return Text(widget.userStorage.userData!.lastName!);
    } else {
      return Text(Languages.of(context)!.lastName);
    }
  }

  void updateFirstName(String firstName) {
    widget.userStorage.setFirstName(firstName);
    _saveProfile();
  }

  void _saveProfile() {
    widget.userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.profileChangeSuccessful);
  }

  void updateLastName(String lastName) {
    widget.userStorage.setLastName(lastName);
    _saveProfile();
  }

  void imagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(gc.galleryChoice),
                    title: Text(Languages.of(context)!.gallery),
                    onTap: () async {
                      if (await Permission.storage.request().isGranted) {
                        await updateAvatar(ImageSource.gallery);
                      }
                      navigateBack(context);
                    }),
                ListTile(
                  leading: const Icon(gc.cameraChoice),
                  title: Text(Languages.of(context)!.camera),
                  onTap: () async {
                    if (await Permission.camera.request().isGranted) {
                      await updateAvatar(ImageSource.camera);
                    }
                    navigateBack(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> updateAvatar(ImageSource image) async {
    ImagePicker picker = ImagePicker();

    XFile? pickedImage = await picker.pickImage(source: image);

    if (pickedImage == null) {
      displaySnackBar(context, Languages.of(context)!.noImagePicked);
    } else {
      setState(() {
        widget.authRepository.uploadAvatar(pickedImage);
      });
    }
  }

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.profileSettings +
          ' ' +
          Languages.of(context)!.settings),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            UserAvatar(widget.authRepository, gc.profileAvatarRadius),
            Padding(
              padding: const EdgeInsets.fromLTRB(gc.padAroundPencil,
                  gc.padProfileAvatar, gc.padAroundPencil, gc.padAroundPencil),
              child: pencilButton(() async {
                imagePicker(context);
              }),
            ),
          ]),
          TextBox(
            _controllerFirstName,
            null,
            labelText: getFirstName(),
            haveBorder: false,
            suffix: pencilButton(() {
              updateFirstName(_controllerFirstName.text);
            }),
          ),
          TextBox(
            _controllerLastName,
            null,
            labelText: getLastName(),
            haveBorder: false,
            suffix: pencilButton(() {
              updateLastName(_controllerLastName.text);
            }),
          ),
        ],
      ),
    );
  }
}
