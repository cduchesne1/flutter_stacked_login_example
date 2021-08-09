import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';
import '../../error/failures.dart';
import '../../injection_container.dart';
import '../../util/input_validator.dart';
import '../domain/usecases/login.dart';

class AuthentificationViewModel extends BaseViewModel {
  final NavigationService _navigationService = sl<NavigationService>();
  final DialogService _dialogService = sl<DialogService>();
  final Login _login = sl<Login>();
  final InputValidator _inputValidator = sl<InputValidator>();
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String _email;
  late String _password;

  AuthentificationViewModel();

  String get email => _email;

  String get password => _password;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  String? validateEmail(String? input) {
    final emailIsValid = _inputValidator.validateEmailInput(input);

    if (emailIsValid.isLeft()) {
      return 'Invalid email address.';
    }
    return null;
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return 'You must enter a password.';
    }
    return null;
  }

  Future login() async {
    final result = await _login(
        Params(email: emailController.text, password: passwordController.text));
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
    }, (success) => _navigationService.replaceWith(Routes.myHomePage));
  }
}
