import 'dart:async';

mixin validator {
  //for checking the mail id
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (email, sink) {
    {
      //checking if the mail has @ in it.
      if (email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Invalid Email");
      }
    }
  });

  //for checking the password
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    {
      //checking password length
      if (password.length > 6) {
        sink.add(password);
      } else {
        sink.addError("password length should be greater than 4 characters. ");
      }
    }
  });

  var usernameValidator =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
        {
          //checking if the mail has @ in it.
          if (username.contains("@")) {
            sink.add(username);
          } else {
            sink.addError("Invalid username");
          }
        }
      });

}
