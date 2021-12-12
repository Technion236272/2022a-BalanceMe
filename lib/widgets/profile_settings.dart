import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'appbar.dart';
import 'bottom_navigation.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';

class ProfileSettings extends StatefulWidget {
   const ProfileSettings({Key? key, required this.authRepository}) : super(key: key);
   final AuthRepository authRepository;
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  int _selectedPage = gc.settingPageIndex;
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  Widget pencilButton(VoidCallback? onPressed)
  {
    return IconButton(onPressed: onPressed, icon:
    const Icon(gc.editPencil,color: gc.alternativePrimary,),
    );
  }
  void _updateSelectedPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
  Widget getProfileScreen() {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(_selectedPage,_updateSelectedPage),
      appBar: MinorAppBar(Languages.of(context)!.profileSettings+' '+Languages.of(context)!.settings),
      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                UserAvatar(widget.authRepository, gc.ProfileAvatarRadius),
                Padding(
                  padding:  const EdgeInsets.fromLTRB(gc.padAroundPencil,gc.padProfileAvatar,gc.padAroundPencil,gc.padAroundPencil),
                  child: pencilButton(updateAvatar),
                ),
              ]),
          TextBox(controllerFirstName, null,labelText:Text(Languages.of(context)!.firstName) ,haveBorder: false,suffix:pencilButton(updateFirstName) ,),
          TextBox(controllerLastName, null,labelText:Text(Languages.of(context)!.lastName) ,haveBorder: false,suffix:pencilButton(updateLastName) ,),
        ],
      ),
    );
  }
  void updateFirstName()
  {

  }
  void updateLastName()
  {

  }
  void updateAvatar()
  {

  }
@override
void dispose()
{
  controllerFirstName.dispose();
  controllerLastName.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return getProfileScreen();
  }
}
