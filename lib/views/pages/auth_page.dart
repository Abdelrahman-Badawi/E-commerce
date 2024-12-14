import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/assets.dart';
import 'package:e_commerce/utilities/enums.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:e_commerce/views/widgets/main_dialog.dart';
import 'package:e_commerce/views/widgets/soical_media_botton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //var _authType = AuthformType.login;

  final _emailFocuseNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;
    } catch (e) {
      MainDialog(
              context: context,
              title: 'Error Authentication',
              content: e.toString())
          .showAlertDialog();
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //           title: Text(
      //             'Error',
      //             style: Theme.of(context).textTheme.headlineMedium,
      //           ),
      //           content: Text(
      //             e.toString(),
      //             style: Theme.of(context).textTheme.headlineSmall,
      //           ),
      //           actions: [
      //             TextButton(
      //                 onPressed: () => Navigator.of(context).pop(),
      //                 child: Text(
      //                   'Ok',
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .headlineMedium!
      //                       .copyWith(color: Colors.blue),
      //                 )),
      //           ],
      //         ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthBase>(context);

    return Consumer<AuthController>(
      builder: (context, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.authformType == AuthformType.login
                          ? 'Login'
                          : 'Register',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocuseNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      textInputAction: TextInputAction.next,
                      onChanged: model.updateEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your email' : null,
                      decoration: const InputDecoration(
                          labelText: 'Email', hintText: 'Enter your email!'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onChanged: model.updatePassword,
                      obscureText: true,
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter your password' : null,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password!'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (model.authformType == AuthformType.login)
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text(
                            'Forgot your password',
                          ),
                          onTap: () {},
                        ),
                      ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    MainBotton(
                      text: model.authformType == AuthformType.login
                          ? 'Login'
                          : 'Register',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          debugPrint('Email : ${model.email}');
                          debugPrint('password : ${model.password}');
                          _submit(model);

                          debugPrint('Authenticated');
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          child: Text(
                            model.authformType == AuthformType.login
                                ? 'Don\'t have an accout? Register'
                                : 'Have an account? Login',
                          ),
                          onTap: () {
                            _formKey.currentState!.reset();
                            model.toggleFormType();
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        model.authformType == AuthformType.login
                            ? 'Or login with'
                            : 'Or register with',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SoicalMediaBotton(
                          iconName: AppAssets.facebookIcon,
                          onpress: () {},
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        SoicalMediaBotton(
                          iconName: AppAssets.googleIcon,
                          onpress: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
