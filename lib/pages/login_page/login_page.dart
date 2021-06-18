import 'package:desafio_byebnk/api/login_api.dart';
import 'package:desafio_byebnk/pages/user_page/user_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;
  String? password;

  @override
  void initState() {
    LoginApi().login(username, password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView(
            children: [
              Card(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String? login) {
                    username = login;
                  },
                ),
              ),
              Card(
                child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    onChanged: (String? passwords) {
                      password = passwords;
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: ElevatedButton(
                    child: Text('Entrar'),
                    onPressed: () async {
                      var user = await LoginApi().login(username, password);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              token: user.token,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      ('Por favor digite o login e senhas corretos')),
                                );
                              });
                        });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
