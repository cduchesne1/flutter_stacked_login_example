import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/colors.dart';
import 'authentification_viewmodel.dart';

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
                      child: const TabBarView(
                        children: [
                          LoginForm(),
                          RegisterForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AuthentificationViewModel>.reactive(
        builder: (context, model, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: _width * (40 / 414)),
              child: Form(
                key: model.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: model.emailController,
                      onChanged: model.updateEmail,
                      validator: (value) => model.validateEmail(value),
                      style: TextStyle(
                          fontSize: _height * (16 / 896), color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize: _height * (11 / 896),
                            color: AppColors.blue),
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
                      controller: model.passwordController,
                      onChanged: model.updatePassword,
                      validator: (value) => model.validatePassword(value),
                      obscureText: true,
                      style: TextStyle(
                          fontSize: _height * (16 / 896), color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: _height * (11 / 896),
                            color: AppColors.blue),
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
                            if (model.formKey.currentState!.validate()) {
                              await model.login();
                            }
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.blue),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
                            color: Colors.white,
                            fontSize: _height * (16 / 896)),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Create',
                              style: TextStyle(color: AppColors.blue)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => AuthentificationViewModel());
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
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
