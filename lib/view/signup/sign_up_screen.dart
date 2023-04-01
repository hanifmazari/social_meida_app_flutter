import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view_model/sign_up/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernamrFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usernamrFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ChangeNotifierProvider(
            create: (_)=> SignUpController(),
            child: Consumer<SignUpController>(
              builder:(context, provider, child) {
                return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Weclcom to Talky Shalky",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter your email address \nto register your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.06, bottom: height * 0.01),
                      child: Column(
                        children: [
                          InputTextFeld(
                              myController: usernameController,
                              focusNode: usernamrFocusNode,
                              onFieldSubmittedValue: (value) {
                                Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                              },
                              enable: true,
                              keyBoardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'User Name',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Username' : null;
                              }),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          InputTextFeld(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFieldSubmittedValue: (value) {},
                              enable: true,
                              keyBoardType: TextInputType.emailAddress,
                              obscureText: false,
                              hint: 'Email',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Email' : null;
                              }),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          InputTextFeld(
                              myController: passwordController,
                              focusNode: passwordFocusNode,
                              onFieldSubmittedValue: (value) {},
                              enable: true,
                              keyBoardType: TextInputType.emailAddress,
                              obscureText: true,
                              hint: 'Password',
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Password' : null;
                              }),
                        ],
                      ),
                    )),
                const SizedBox(height: 40),
                RoundButton(
                  title: 'Sign Up',
                  loading: provider.loading,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      provider.signup(context, usernameController.text, emailController.text, passwordController.text);
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, RouteName.loginView),
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                            text: 'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline))
                      ])),
                )
              ],
            ),
          );
              } ),
          )
        ),
      ),
    );
  }
}
