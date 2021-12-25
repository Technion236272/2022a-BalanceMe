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
  bool _isDisabledFirstName = true;
  bool _isDisabledLastName = true;

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerFirstName = TextEditingController(text: _getFirstName());
    _controllerLastName = TextEditingController(text: _getLastName());
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

  bool _enableEditCondition(String? value, StringCallback nameCallback) => (value == null || value == nameCallback() || value == "");

  void _enableEditFirstName(String? value) {
    setState(() {
      _isDisabledFirstName = _enableEditCondition(value, _getFirstName);
    });
  }

  void _enableEditLastName(String? value) {
    setState(() {
      _isDisabledLastName = _enableEditCondition(value, _getLastName);
    });
  }

  void _saveProfile() {
    widget.userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.strProfileUpdateSuccessful);
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
    titles.add(Languages.of(context)!.strGalleryOption);
    titles.add(Languages.of(context)!.strCameraOption);
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
      displaySnackBar(context, Languages.of(context)!.strNoImagePicked);
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
      appBar: MinorAppBar(Languages.of(context)!.strProfileSettings),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: gc.avatarPadding,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width/gc.avatarSizeScale,
                      height: MediaQuery.of(context).size.width/gc.avatarSizeScale,
                      child: UserAvatar(widget.authRepository, gc.profileAvatarRadius)),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width/gc.avatarEditIconPosition,
                  top: MediaQuery.of(context).size.width/(gc.avatarEditIconHeightPosition),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(gc.padAroundPencil, gc.padProfileAvatar, gc.padAroundPencil, gc.padAroundPencil),
                    child: GenericIconButton(onTap: _showImageSourceChoice),
                  ),
                ),
              ],
            ),
            Padding(
              padding: gc.emailContainerPadding,
              child: Visibility(
                  visible: widget.authRepository.user != null,
                  child: Container(
                      decoration: BoxDecoration(
                        color: gc.emailContainerBGColor,
                        borderRadius: BorderRadius.circular(gc.emailContainerBorderRadius),
                        border: Border.all(color: gc.primaryColor)
                      ),
                      child: Padding(
                        padding: gc.emailContainerPadding,
                        child: Text(
                          widget.authRepository.user!.email!,
                          style: const TextStyle(
                              fontSize: gc.emailContainerFontSize,
                              color: gc.primaryColor),),
                      )),
              ),
            ),
            TextBox(
              _controllerFirstName,
              Languages.of(context)!.strFirstName,
              haveBorder: false,
              labelText: Text(Languages.of(context)!.strFirstName),
              onChanged: _enableEditFirstName,
              suffix: GenericIconButton(
                onTap: _updateFirstName,
                isDisabled: _isDisabledFirstName,
                opacity: gc.disabledOpacity,
              ),
            ),
            TextBox(
              _controllerLastName,
              Languages.of(context)!.strLastName,
              haveBorder: false,
              labelText: Text(Languages.of(context)!.strLastName),
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
