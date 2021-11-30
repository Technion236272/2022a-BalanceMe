import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart' as auth;
import 'package:balance_me/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:balance_me/widgets/generic_tabs.dart';
bool showPassword=true;
bool signUpPasswordVisible=true;
bool confirmPasswordVisible=true;
String? email;
String? password;
String? confirmPassword;
int appBarChoice=0;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //generic tab attempt
  List<Tab> loginTabs()
  {
    return [Tab( child:
  Text(Languages.of(context)!.login,
  style: const TextStyle(color: gc.tabTextColor),
  )),
  Tab(child:Text(Languages.of(context)!.signUpTitle,
  style: const TextStyle(color: gc.tabTextColor),
    ) ,)];
}
List<Widget> loginTabBarView()
{
  return  [
loginBody(context),
signUpBody(context),

  ];
}

void changeAppbar(int tabIndex)
{
setState(() {
  appBarChoice=tabIndex;
});
}
  Widget signUpBody(BuildContext context)
  {
    //showPassword=false;
    return Form(child: Column(children: [

      Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(

          onChanged:(String? value){email=value;},
          decoration: InputDecoration (

            hintText:Languages.of(context)!.emailText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(gc.textFieldRadius),
              borderSide: BorderSide(
                color: gc.primaryColor,
                width: 2.0,
              ),
            ),
          ),

        ),
      ),

      Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(
          obscureText: signUpPasswordVisible,
          onChanged:(String? value){password=value;},
          decoration: InputDecoration (
              hintText:Languages.of(context)!.password,

              suffixIcon: IconButton(icon:Icon(signUpPasswordVisible? gc.hidePassword:gc.showPassword)
                ,onPressed:(){setState(() {
                  signUpPasswordVisible=!signUpPasswordVisible;
                });} ,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(gc.textFieldRadius),
                borderSide: BorderSide(
                  color: gc.primaryColor,
                  width: 2.0,
                ),
              )
          ),),
      ),

      Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(
          obscureText: confirmPasswordVisible,
          onChanged:(String? value){confirmPassword=value;},
          decoration: InputDecoration (
              hintText:Languages.of(context)!.confirmPassword,
              suffixIcon: IconButton(icon:Icon(confirmPasswordVisible? gc.hidePassword:gc.showPassword)
                ,onPressed:(){setState(() {
                  confirmPasswordVisible=!confirmPasswordVisible;
                });} ,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(gc.textFieldRadius),
                borderSide: BorderSide(
                  color: gc.primaryColor,
                  width: 2.0,
                ),
              )
          ),),
      ),

      Row(children: [

        Padding(

          padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
              gc.paddingFacebook,gc.paddingFacebook,gc.paddingFacebook),

          child: GoogleAuthButton(
            onPressed: () {signUpGoogle();},
            darkMode: false,
            style: const AuthButtonStyle(
              buttonType: AuthButtonType.icon,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(gc.paddingFacebook),
          child: FacebookAuthButton(
            onPressed: () {signUpFacebook();},
            darkMode: false,
            style: const AuthButtonStyle(
              buttonType: AuthButtonType.icon,
            ),
          ),
        ),

      ],),

      SizedBox(

        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(gc.alternativePrimary)),
            onPressed:(){ regularSignUp(email,password);} ,
            child: Text(Languages.of(context)!.signUpTitle)),
      ),

    ],),);

  }
  //TODO: update UserStorage-and add sign up functions
  void signInGoogle()async
  {

    auth.AuthRepository authRepository=auth.AuthRepository.instance();
   bool signInAttempt=await authRepository.signInGoogle();
    if(signInAttempt)
    {
      navigateToPage(context,HomePage());
    }
    else
      {
        displaySnackBar(context,Languages.of(context)!.loginError);

      }

  }
  void signInFacebook() async
  {
    auth.AuthRepository authRepository=auth.AuthRepository.instance();
    bool signInAttempt=await authRepository.signInWithFacebook();
    if (signInAttempt)
    {
      navigateToPage(context, HomePage());
    } else {
      displaySnackBar(context,Languages.of(context)!.loginError);
    }
  }

  void signUpGoogle()async
  {

    auth.AuthRepository authRepository=auth.AuthRepository.instance();
    bool signInAttempt=await authRepository.signInGoogle();
    if(signInAttempt)
    {
      navigateToPage(context,HomePage());
    }
    else
    {
      displaySnackBar(context,Languages.of(context)!.loginError);

    }
  }
  void signUpFacebook() async
  {
    auth.AuthRepository authRepository=auth.AuthRepository.instance();
    bool signInAttempt=await authRepository.signInWithFacebook();
    if (signInAttempt)
    {
      navigateToPage(context, HomePage());
    } else {
      displaySnackBar(context,Languages.of(context)!.loginError);
    }
  }
  void regularSignUp(String? email,String? password)async
  {
    if (email==null || password==null)
    {
      displaySnackBar(context,Languages.of(context)!.loginError);
      return;
    }
    auth.AuthRepository _auth=auth.AuthRepository.instance();
   await _auth.signUp(email, password);
    navigateToPage(context,HomePage());

  }
@override
void initState()
{
  super.initState();


}
  void regularSignIn(String? email,String? password)async
  {
    if (email==null || password==null)
    {
      displaySnackBar(context,Languages.of(context)!.loginError);
      return;
    }
    auth.AuthRepository _auth=auth.AuthRepository.instance();
    bool signInSuccesful=await _auth.signIn(email, password);
    navigateToPage(context,HomePage());

  }
  //TODO: find a free image and attribute it
  Widget forgotPasswordPage()
  {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.recoverPassword),
      body: Container(),

    );
  }
  void changePasswordVisibility()
  {
    setState(() {
      showPassword=!showPassword;
    });

  }
  Widget loginBody(BuildContext context)
  {
    return Form(child: Column(children: [

      Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(

          onChanged:(String? value){email=value;},
          decoration: InputDecoration (

              hintText:Languages.of(context)!.emailText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(gc.textFieldRadius),
              borderSide: BorderSide(
                color: gc.primaryColor,
                width: 2.0,
              ),
            ),
          ),

        ),
      ),
      
      Padding(
        padding: const EdgeInsets.all(gc.paddingBetweenText),
        child: TextFormField(
          obscureText: showPassword,
          onChanged:(String? value){password=value;},
          decoration: InputDecoration (
            hintText:Languages.of(context)!.password,
            suffixIcon: IconButton(icon:Icon(showPassword? gc.hidePassword:gc.showPassword )
              ,onPressed:(){
              setState(() {
                showPassword=!showPassword;
              }
              );;} ,),


              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(gc.textFieldRadius),
                borderSide: BorderSide(
                  color: gc.primaryColor,
                  width: 2.0,
                ),
              )
          ),),
      ),

      Row(children: [

        Padding(

          padding: const EdgeInsets.fromLTRB(gc.googleButtonPadding,
              gc.paddingFacebook,gc.paddingFacebook,gc.paddingFacebook),

          child: GoogleAuthButton(
            onPressed: () {signInGoogle();},
            darkMode: false,
            style: const AuthButtonStyle(
              buttonType: AuthButtonType.icon,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(gc.paddingFacebook),
          child: FacebookAuthButton(
            onPressed: () {signInFacebook();},
            darkMode: false,
            style: const AuthButtonStyle(
              buttonType: AuthButtonType.icon,
            ),
          ),
        ),

      ],),
      TextButton(onPressed:(){
        navigateToPage(context,forgotPasswordPage());} ,
          child: Text(Languages.of(context)!.forgotPassword,style: TextStyle(color: gc.linkColors),)),


      SizedBox(

        child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(gc.alternativePrimary)),
            onPressed:(){ regularSignIn(email,password);} ,
            child: Text(Languages.of(context)!.signIn)),
      ),

    ],),);
  }
  @override
  Widget build(BuildContext context)
  {
    return
       DefaultTabController(
        length: gc.loginTabs,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:appBarChoice==0? MinorAppBar(Languages.of(context)!.login):MinorAppBar(Languages.of(context)!.signUpTitle),
          body: TabGeneric(loginTabs(),loginTabBarView(),onSwitch: changeAppbar),
        ),
      );
  }
}