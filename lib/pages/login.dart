//this is the login UI
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/tab_with_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:balance_me/global/utils.dart';

late bool _passwordVisible;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.login),
      body: tabBody(),


    );
  }
@override
void initState ()
{

super.initState();
_passwordVisible=false;
}
  Widget tabBody()
  {

return Container(
  child: Column(children: [
      TabLogin(),
    TabBarView(children: [loginBody(),signUpBody()]),



  ],),
);
  }
  //TODO: find a royalty free wallet image-or attribute it
  Widget loginBody()
  {
    return Form(child: Column(children: [
      TextFormField(decoration: InputDecoration (
          hintText:Languages.of(context)!.emailText ),),
      TextFormField(decoration: InputDecoration (
          hintText:Languages.of(context)!.password,
      suffixIcon: IconButton(icon:Icon(_passwordVisible? gc.hidePassword:gc.showPassword)
        ,onPressed:changePasswordVisibility ,),

      ),),
    //TODO: figure out how to set up google and facebook authentication
    Row(children: [SignInButton(Buttons.Google,mini: true, onPressed: signInGoogle),
      SignInButton(Buttons.Facebook,mini: true, onPressed: signInFacebook),
    ],),
    TextButton(onPressed:(){navigateToPage(context,forgotPasswordPage());} ,
  child: Text(Languages.of(context)!.forgotPassword)),
      TextButton(onPressed:(){ regularSignIn();} ,
          child: Text(Languages.of(context)!.signIn)),
     //TODO: consider not adding a don't have an account link since we have tabs
    ],),);
  }
  Widget signUpBody()
  {
    return Container();
  }
  Widget forgotPasswordPage()
  {
    return Container();
  }
  void changePasswordVisibility()
  {
    _passwordVisible=!_passwordVisible;
  }
  void signInGoogle()
  {

  }
  void signInFacebook()
  {

  }
  void regularSignIn()
  {

  }


}
