//this is the login UI
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/tab_with_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
//TODO: put the appbar and bottomNav designed here
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: tabBody(),
    );
  }
//TODO: create a TabBar Default controller
  Widget tabBody()
  {

return Container(
  child: Column(children: [
      TabLogin(),
    TabBarView(children: [loginBody(),signUpBody()]),



  ],),
);
  }
  //TODO: find a royalty free wallet image
  Widget loginBody()
  {
    return Form(child: Column(children: [
      TextFormField(decoration: InputDecoration (
          hintText:Languages.of(context)!.emailText ),)
    
    ],),);
  }
  Widget signUpBody()
  {
    return Container();
  }
}
