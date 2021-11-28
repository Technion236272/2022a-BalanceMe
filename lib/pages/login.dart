//this is the login UI
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/tab_with_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/pages/home.dart';

late bool passwordVisible;
 String? email;
 String? password;

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
passwordVisible=false;

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
      TextFormField(
        onChanged:(String? value){email=value;},
        decoration: InputDecoration (
          hintText:Languages.of(context)!.emailText ),

      ),
      TextFormField(
        onChanged:(String? value){password=value;},
        decoration: InputDecoration (
          hintText:Languages.of(context)!.password,
      suffixIcon: IconButton(icon:Icon(passwordVisible? gc.hidePassword:gc.showPassword)
        ,onPressed:changePasswordVisibility ,),

      ),),
    //TODO:enable authentication via Google and Facebook
    Row(children: [SignInButton(Buttons.Google,mini: true, onPressed: signInGoogle),
      SignInButton(Buttons.Facebook,mini: true, onPressed: signInFacebook),
    ],),
    TextButton(onPressed:(){navigateToPage(context,forgotPasswordPage());} ,
  child: Text(Languages.of(context)!.forgotPassword)),


      TextButton(onPressed:(){ regularSignIn(email,password);} ,
          child: Text(Languages.of(context)!.signIn)),

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
    passwordVisible=!passwordVisible;
  }
  void signInGoogle()
  {

  }
  void signInFacebook()
  {

  }

  void regularSignIn(String? email,String? password)async
  {
    if (email==null || password==null)
    {
      displaySnackBar(context,Languages.of(context)!.loginError);
      return;
    }
    AuthRepository _auth=AuthRepository.instance();
  bool signInSuccesful=await _auth.signIn(email, password);
    navigateToPage(context,HomePage());
  }


}
