import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
bool showPassword=true;
bool signUpPasswordVisible=true;
bool confirmPasswordVisible=true;
String? email;
String? password;
String? confirmPassword;
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
  //TODO: update UserStorage
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
            onPressed: () {},
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
            onPressed:(){ regularSignIn(email,password);} ,
            child: Text(Languages.of(context)!.signUpTitle)),
      ),

    ],),);
    ;
  }
  void signInGoogle()async
  {

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [

        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
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
  void signInFacebook() async
  {
     final LoginResult result = await FacebookAuth.instance.login(permissions:gc.permissionFacebook);

    if (result.status == LoginStatus.success)
    {
      final AccessToken accessToken = result.accessToken!;
      navigateToPage(context, HomePage());
    } else {
      displaySnackBar(context,Languages.of(context)!.loginError);
    }
  }
@override
void initState()
{
  super.initState();
   //passwordVisible=true;
  confirmPasswordVisible=true;

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