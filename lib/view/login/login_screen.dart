import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
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
                  "Enter your email address \nto connect to your account",
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.forgotScreen);    
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                      builder: ((context, provider, child) {
                    return RoundButton(
                      title: 'Login',
                      loading:provider.loading,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.login(context, emailController.text , passwordController.text.toString());
                        }
                      },
                    );
                  })),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteName.signUpScreen),
                  child: Text.rich(TextSpan(
                      text: "Dont't have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
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
          ),
        ),
      ),
    );
  }
}
