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
    if (widget.userStorage.userData != null) {
      widget.userStorage.userData!.firstName = _controllerFirstName.text;
      _saveProfile();
      _enableEditFirstName(null);
    } else {
      displaySnackBar(context, Languages.of(context)!.strProblemOccurred);
    }
  }

  void _updateLastName() {
    if (widget.userStorage.userData != null) {
      widget.userStorage.userData!.lastName = _controllerLastName.text;
      _saveProfile();
      _enableEditLastName(null);
    } else {
      displaySnackBar(context, Languages.of(context)!.strProblemOccurred);
    }
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
    imagePicker(_getActions(), _iconsLeading(), _getOptionTitles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.strProfileSettings),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: gc.avatarPadding,
              child: SizedBox(
                width: MediaQuery.of(context).size.width/gc.avatarSizedBoxWidthScale,
                height: MediaQuery.of(context).size.width/gc.avatarSizedBoxHeightScale,
                child: Stack(
                  children: [
                    UserAvatar(widget.authRepository, MediaQuery.of(context).size.width/gc.profileAvatarRadiusScale),
                    Positioned(
                      right:0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(gc.padAroundPencil, gc.padProfileAvatar, gc.padAroundPencil, gc.padAroundPencil),
                        child: GenericIconButton(onTap: _showImageSourceChoice),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: gc.emailContainerPadding,
              child: Visibility(
                  visible: widget.authRepository.user != null,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).toggleableActiveColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(gc.emailContainerBorderRadius),
                        border: Border.all(color: Theme.of(context).toggleableActiveColor)
                      ),
                      child: Padding(
                        padding: gc.emailContainerPadding,
                        child: Text(
                          widget.authRepository.user!.email!,
                          style: Theme.of(context).textTheme.caption),
                      )),
              ),
            ),
            TextBox(
              _controllerFirstName,
              Languages.of(context)!.strFirstName,
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
              Languages.of(context)!.strLastName,
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
