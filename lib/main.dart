import 'package:flutter/material.dart';


import 'bloc.dart';
import 'home.dart';
import 'signup.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        'login':(context) => LoginPage(),
        'register':(context) => SignUp(),
        'home':(context) => Home(),

      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

//login page
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();

}


class _LoginState extends State<SignUp> {


  changeThePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  void initState(){
    super.initState(); //error cause stateless widget, make it a stateless widget
     }


  @override
  Widget build(BuildContext context) {


    final bloc = Bloc();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                stream: bloc.email,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.emailChanged,textAlign: TextAlign.center,
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
                builder: (context, snapshot) => TextField(textAlign: TextAlign.center,
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
                  onPressed: (){
                    print(bloc.emailController.stream.value);
                    print(bloc.passwordController.stream.value);
                  },

                  child: Text("Submit"),
                ),
              ),
              FlatButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));

              },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
