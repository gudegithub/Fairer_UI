
import 'package:fairer_ui/service/auth.dart';
import 'package:flutter/material.dart';
class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          String user = await widget.auth.signIn(_email, _password);
          print('Signed in: $user');
        } else {
          String user = await widget.auth.signUp(_email, _password);
          print('Signed up user: $user');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  void googleSignIn() {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    try {
      widget.auth.signInWithGoogle();
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          _form(),
          _circularProgress(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[50],
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: footerMessage(),
        )
      ),
    );
  }

  Widget _circularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _form() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                logo(),
                emailInput(),
                passwordInput(),
                loginButton(),
                border(),
                googleLoginButton(),
                causionMessage(),
                errorMessage(),
              ],
            ),
          ),
        ));
  }

  Widget errorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Image.asset("assets/image/Fairer_logo.png")
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("あなたに最高の学生生活を"),
          )
        ],
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )
          ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget secondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget primaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.orange,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        )
      );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity, 
        child: RaisedButton(
          child: Text(
            _isLoginForm ? "ログイン" : "会員登録",
            style: TextStyle(color: Colors.white)
          ),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {
            validateAndSubmit();
          },
        ),
      ),
    );
  }

  Widget border() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Divider(color: Colors.black38),),
          SizedBox(width: 20.0,),
          Text("または"),
          SizedBox(width: 20.0),
          Expanded(child: Divider(color: Colors.black38),)
        ],
      ),
    );
  }

    Widget googleLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/image/google_icon.png',
              width: 30.0,
            ),
            SizedBox(width: 20.0,),
            Text(_isLoginForm ? "Googleでログイン" : "Googleで登録")
          ],
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        onPressed: () {
          googleSignIn();
        },
      ),
    );
  }

  Widget causionMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          '利用規約と個人情報保護方針に同意の上ご利用下さい',
          style: TextStyle(
            fontSize: 10,
            
          )
        ),
      ),
    );
  }


  Widget footerMessage() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text( _isLoginForm ? "アカウントをお持ちではありませんか？" : "すでにアカウントをお持ちですか？"),
        SizedBox(width: 10.0,),
        GestureDetector(
          onTap: () {
            toggleFormMode();
          },
          child: Text(
            _isLoginForm ? "会員登録" : "ログイン",
            style: TextStyle(
              color: Colors.blue
            )
          ),
        ),
      ],
    );
  }

}
