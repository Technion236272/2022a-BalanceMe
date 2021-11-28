import 'package:flutter/material.dart';
import 'package:balance_me/widgets/tab_with_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

late bool passwordVisible;
String? email;
String? password;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget tabs(BuildContext context)
  {
    return Container(color:gc.tabColor,
      child: TabBar(
        tabs: [Tab( child:
        Text(Languages.of(context)!.login,
          style: const TextStyle(color: gc.tabTextColor),
        )),
          Tab(child:Text(Languages.of(context)!.signUpTitle,
            style: const TextStyle(color: gc.tabTextColor),
          ) ,)],),);
  }
  Widget signUpBody(BuildContext context)
  {
    return Container();
  }
  void signInGoogle()async
  {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? googleAccount= await _googleSignIn.signIn();
    if(googleAccount==null)
    {
      _googleSignIn.disconnect();
      displaySnackBar(context,Languages.of(context)!.loginError);
    }
    navigateToPage(context,HomePage());
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
  Widget forgotPasswordPage()
  {
    return Container();
  }
  void changePasswordVisibility()
  {
    passwordVisible=!passwordVisible;
  }
  Widget loginBody(BuildContext context)
  {
    passwordVisible=false;
    return Form(child: Column(children: [
      TextFormField(

        onChanged:(String? value){email=value;},
        decoration: InputDecoration (
            hintText:Languages.of(context)!.emailText

        ),

      ),
      TextFormField(
        onChanged:(String? value){password=value;},
        decoration: InputDecoration (
          hintText:Languages.of(context)!.password,
          suffixIcon: IconButton(icon:Icon(passwordVisible? gc.hidePassword:gc.showPassword)
            ,onPressed:changePasswordVisibility ,),

        ),),
      //TODO:enable authentication ios google+facebook
      Row(children: [SignInButton(Buttons.Google, onPressed: signInGoogle),
        SignInButton(Buttons.Facebook,mini: true, onPressed: signInFacebook),
      ],),
      TextButton(onPressed:(){navigateToPage(context,forgotPasswordPage());} ,
          child: Text(Languages.of(context)!.forgotPassword)),


      TextButton(onPressed:(){ regularSignIn(email,password);} ,
          child: Text(Languages.of(context)!.signIn)),

    ],),);
  }
  @override
  void initState ()
  {
    super.initState();
    passwordVisible=false;
  }
  @override
  Widget build(BuildContext context) {
    return
       DefaultTabController(
        length: gc.loginTabs,
        child: Scaffold(
          appBar: MinorAppBar(Languages.of(context)!.login),
          body: Column(
            children: [
            tabs(context),
              Expanded(
                child:  TabBarView(
                  children: [
                    loginBody(context),
                    signUpBody(context),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}