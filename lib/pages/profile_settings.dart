// ================= Profile Page =================
import 'package:balance_me/global/types.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:balance_me/widgets/image_picker.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key, required this.authRepository, required this.userStorage}) : super(key: key);

  final AuthRepository authRepository;
  final UserStorage userStorage;

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late TextEditingController _controllerFirstName;
  late TextEditingController _controllerLastName;
  late TextEditingController _controllerEmail;
  bool _isDisabledFirstName = true;
  bool _isDisabledLastName = true;

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerFirstName = TextEditingController(text: _getFirstName());
    _controllerLastName = TextEditingController(text: _getLastName());
    _controllerEmail=TextEditingController(text: widget.authRepository.user?.email);
  }

  String? _getFirstName() {
    if (widget.authRepository.status == AuthStatus.Authenticated && widget.userStorage.userData != null && widget.userStorage.userData!.firstName != null) {
      return widget.userStorage.userData!.firstName!;
    }
    return null;
  }

  String? _getLastName() {
    if (widget.authRepository.status == AuthStatus.Authenticated && widget.userStorage.userData != null && widget.userStorage.userData!.lastName != null) {
      return widget.userStorage.userData!.lastName!;
    }
    return null;
  }

  void _enableEditFirstName(String? value) {
    setState(() {
      _isDisabledFirstName = (value == null);
    });
  }

  void _enableEditLastName(String? value) {
    setState(() {
      _isDisabledLastName = (value == null);
    });
  }

  void _saveProfile() {
    widget.userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.profileChangeSuccessful);
  }

  void _updateFirstName() {
    widget.userStorage.setFirstName(_controllerFirstName.text);
    _saveProfile();
    _enableEditFirstName(null);
  }

  void _updateLastName() {
    widget.userStorage.setLastName(_controllerLastName.text);
    _saveProfile();
    _enableEditLastName(null);
  }

  List<GestureTapCallback?> _getActions() {
    List<GestureTapCallback?> imageOptions = [];
    imageOptions.add(() async {
      await _chooseAvatarSource(ImageSource.gallery);
    });
    imageOptions.add(() async {
      await _chooseAvatarSource(ImageSource.camera);
    });
    return imageOptions;
  }

  List<Widget?> _iconsLeading() {
    List<Widget?> icons = [];
    icons.add(const Icon(gc.galleryChoice));
    icons.add(const Icon(gc.cameraChoice));
    return icons;
  }

  List<String> _getOptionTitles() {
    List<String> titles = [];
    titles.add(Languages.of(context)!.gallery);
    titles.add(Languages.of(context)!.camera);
    return titles;
  }

  Future<void> _chooseAvatarSource(ImageSource source) async {
    if (source == ImageSource.gallery) {
      if (await Permission.storage.request().isGranted) {
        await _updateAvatar(ImageSource.gallery);
      }
    } else {
      if (await Permission.camera.request().isGranted) {
        await _updateAvatar(ImageSource.camera);
      }
    }
    navigateBack(context);
  }

  Future<void> _updateAvatar(ImageSource image) async {
    ImagePicker picker = ImagePicker();

    XFile? pickedImage = await picker.pickImage(source: image);

    if (pickedImage == null) {
      displaySnackBar(context, Languages.of(context)!.noImagePicked);
    } else {
      setState(() {
        widget.authRepository.uploadAvatar(pickedImage);
      });
    }
    GoogleAnalytics.instance.logAvatarChange();
  }

  void _showImageSourceChoice() async {
    imagePicker(context, _getActions(), _iconsLeading(), _getOptionTitles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.profilePageTitle),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserAvatar(widget.authRepository, gc.profileAvatarRadius),
                Padding(
                  padding: const EdgeInsets.fromLTRB(gc.padAroundPencil, gc.padProfileAvatar, gc.padAroundPencil, gc.padAroundPencil),
                  child: GenericIconButton(onTap: _showImageSourceChoice),
                ),
              ],
            ),
            TextBox(_controllerEmail, widget.authRepository.user?.email),
            TextBox(
              _controllerFirstName,
              Languages.of(context)!.firstName,
              haveBorder: false,
              onChanged: _enableEditFirstName,
              suffix: GenericIconButton(
                onTap: _updateFirstName,
                isDisabled: _isDisabledFirstName,
                opacity: gc.disabledOpacity,
              ),
            ),
            TextBox(
              _controllerLastName,
              Languages.of(context)!.lastName,
              haveBorder: false,
              onChanged: _enableEditLastName,
              suffix: GenericIconButton(
                onTap: _updateLastName,
                isDisabled: _isDisabledLastName,
                opacity: gc.disabledOpacity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
