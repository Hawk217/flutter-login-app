import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validator.dart';


class Bloc extends Object with validator implements BaseBloc {

  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final usernameController = BehaviorSubject<String>();


  Function(String) get emailChanged => emailController.sink.add;
  Function(String) get passwordChanged => passwordController.sink.add;
  Function(String) get usernameChanged => usernameController.sink.add;


  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get email => emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      passwordController.stream.transform(passwordValidator);
  Stream<String> get username =>
      usernameController.stream.transform(passwordValidator);


  Stream<bool> get submitEnable =>
      Observable.combineLatest2(email, password, (e, p) => true);

  submit() {
    print("xyx");
  }

  @override
  void dispose() {
    emailController?.close();
    passwordController?.close();
    usernameController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
