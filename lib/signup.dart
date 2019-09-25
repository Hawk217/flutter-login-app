import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'bloc.dart';



class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();

}


class SignUpState extends State<SignUp> {

  final auth = FirebaseAuth.instance ;

  FirebaseUser loggedinUser;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() async {
    try {final user = await auth.currentUser();
    if(user != null){
      loggedinUser = user;
      print(loggedinUser.email);
    } } catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.username,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.usernameChanged,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Username",
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: Icon(Icons.assignment_ind),
                      ),
                      labelText: "Username",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                  height: 20
              ),
              StreamBuilder<String>(
                stream: bloc.email,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.emailChanged,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter email",
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: Icon(Icons.email),
                      ),
                      labelText: "Email",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) => TextField(
                  textAlign: TextAlign.center,
                  onChanged: bloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter password",
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: Icon(Icons.lock),
                      ),
                      labelText: "Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                stream: bloc.submitEnable,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed: () async {
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                          email: bloc.emailController.stream.value,
                          password: bloc.passwordController.stream.value);
                      if(newUser != null){
                        Navigator.pushNamed(context,'home');
                      }
                    }catch (e){
                      print(e);
                    }
                    //print(bloc.usernameController.stream.value);
                    //print(bloc.emailController.stream.value);
                    //print(bloc.passwordController.stream.value);
                  },
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}