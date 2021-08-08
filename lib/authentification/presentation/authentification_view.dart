import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';
import '../../app/colors.dart';
import '../../error/failures.dart';
import '../../injection_container.dart';
import '../../util/input_validator.dart';
import '../domain/usecases/login.dart';

class AuthentificationView extends StatelessWidget {
  const AuthentificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
          width: _width,
          height: _height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _height * (250 / 896),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _width * (40 / 414)),
                    width: _width * (140 / 414),
                    child: TabBar(
                        isScrollable: true,
                        indicatorColor: AppColors.blue,
                        labelPadding:
                            EdgeInsets.only(right: _width * (8 / 414)),
                        labelColor: AppColors.blue,
                        unselectedLabelColor: AppColors.grey,
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          const Tab(
                            text: 'Login',
                          ),
                          const Tab(
                            text: 'Register',
                          )
                        ]),
                  ),
                  SizedBox(
                    height: _height * (40 / 896),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: _width,
                      child: TabBarView(
                        children: [
                          LoginForm(
                            context: context,
                          ),
                          RegisterForm(context: context),
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}

class LoginForm extends StatefulWidget {
  final BuildContext context;
  const LoginForm({Key? key, required this.context}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final NavigationService _navigationService = sl<NavigationService>();
  final DialogService _dialogService = sl<DialogService>();
  final Login _login = sl<Login>();
  final InputValidator _inputValidator = sl<InputValidator>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(widget.context).size.height;
    final double _width = MediaQuery.of(widget.context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _width * (40 / 414)),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                final emailIsValid = _inputValidator.validateEmailInput(value);

                if (emailIsValid.isLeft()) {
                  return 'Invalid email address.';
                }
                return null;
              },
              style: TextStyle(
                  fontSize: _height * (16 / 896), color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                    fontSize: _height * (11 / 896), color: AppColors.blue),
                fillColor: AppColors.veryDarkBlue,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: _height * (20 / 896),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You must enter your password.';
                }
                return null;
              },
              obscureText: true,
              style: TextStyle(
                  fontSize: _height * (16 / 896), color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                    fontSize: _height * (11 / 896), color: AppColors.blue),
                fillColor: AppColors.veryDarkBlue,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: _height * (20 / 896),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text('forgot password?',
                    style: TextStyle(
                        color: AppColors.blue,
                        fontSize: _height * (16 / 896)))),
            SizedBox(
              height: _height * (39 / 896),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: _width, height: _height * (60 / 896)),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final result = await _login(Params(
                          email: emailController.text,
                          password: passwordController.text));
                      result.fold((failure) async {
                        if (failure is AuthentificationFailure) {
                          await _dialogService.showConfirmationDialog(
                              title: 'Oops...',
                              description:
                                  'Could not login with the current credentials. Please check that you have the right credentials and try again.');
                        } else {
                          await _dialogService.showConfirmationDialog(
                              title: 'No connection',
                              description:
                                  'It seems you are not connected to any network! Make sure you are connected to a network and try again!');
                        }
                      },
                          (success) => _navigationService
                              .replaceWith(Routes.myHomePage));
                    }
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: _height * (16 / 896)))),
            ),
            SizedBox(
              height: _height * (30 / 896),
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                    color: Colors.white, fontSize: _height * (16 / 896)),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Create', style: TextStyle(color: AppColors.blue)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final BuildContext context;
  const RegisterForm({Key? key, required this.context}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(widget.context).size.height;
    final double _width = MediaQuery.of(widget.context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _width * (40 / 414)),
      child: Column(
        children: [
          TextField(
            style:
                TextStyle(fontSize: _height * (16 / 896), color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                  fontSize: _height * (11 / 896), color: AppColors.blue),
              fillColor: AppColors.veryDarkBlue,
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: _height * (20 / 896),
          ),
          TextField(
            obscureText: true,
            style:
                TextStyle(fontSize: _height * (16 / 896), color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                  fontSize: _height * (11 / 896), color: AppColors.blue),
              fillColor: AppColors.veryDarkBlue,
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          SizedBox(
            height: _height * (39 / 896),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                width: _width, height: _height * (60 / 896)),
            child: ElevatedButton(
                onPressed: () => {},
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Text('Register',
                    style: TextStyle(
                        color: Colors.white, fontSize: _height * (16 / 896)))),
          ),
          SizedBox(
            height: _height * (30 / 896),
          ),
          RichText(
            text: TextSpan(
              text: 'Already have an account?',
              style: TextStyle(
                  color: Colors.white, fontSize: _height * (16 / 896)),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Login', style: TextStyle(color: AppColors.blue)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
