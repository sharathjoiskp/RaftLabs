import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raftlabs/dashboard.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  var emailController = "";
  var passwordController = "";

  TextEditingController resetEmailController = TextEditingController();
  bool toggleIndex = true;

  void index_reverse() {
    setState(() {
      toggleIndex = !toggleIndex;
    });
  }

  startauthentication() async {
    final validity = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      formKey.currentState!.save();
      submitform(
        emailController,
        passwordController,
      );
    }
  }

  submitform(
    String email,
    String password,
  ) async {
    final auth = FirebaseAuth.instance;

    UserCredential authResult;
    try {
      if (toggleIndex) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.to(Dashboard());
        Fluttertoast.showToast(
            msg: "Login Successful",
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.indigo.shade300,
            textColor: Colors.white,
            fontSize: 16.0);
        index_reverse();
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        Get.to(Dashboard());
        Fluttertoast.showToast(
            msg: "Account Created",
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.indigo.shade300,
            textColor: Colors.white,
            fontSize: 16.0);
        index_reverse();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.indigo.shade300,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    int _tabIconIndexSelected = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text(
          'RaftLabs  📚',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black38,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    border: Border.all(color: Colors.indigo, width: 3),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: toggleIndex ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(27),
                              bottomRight: Radius.circular(27)),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.03,
                        child: GestureDetector(
                          onTap: () {
                            index_reverse();
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: !toggleIndex
                                    ? Colors.black38
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: !toggleIndex ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(27),
                              bottomRight: Radius.circular(27)),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.03,
                        child: GestureDetector(
                          onTap: () {
                            index_reverse();
                          },
                          child: Center(
                            child: Text(
                              'SIGN',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    toggleIndex ? Colors.black38 : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //Body------------------------------------------------------
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: toggleIndex
                          ? Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Signin into your',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Account',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  size_box(),
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey('email'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Incorrect';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      emailController = value!;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: Colors.indigo,
                                      ),
                                      hintText: 'jois@gmail.com',
                                    ),
                                  ),
                                  size_box(),
                                  Text(
                                    'Password',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey('password'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Incorrect';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      passwordController = value!;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.indigo,
                                      ),
                                      hintText: 'Passowrd',
                                    ),
                                  ),
                                  size_box(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Don' "'" 't have an Account ?'),
                                      custom_button(
                                        pbottom: 0,
                                        pleft: 0,
                                        ptop: 0,
                                        text: ' Register Now',
                                        colour: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        onTap: index_reverse,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ) //SIGNUP----------------------
                          : Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Create an',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Account',
                                      style: TextStyle(
                                          color: Colors.lightGreen,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    size_box(),
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.person,
                                          color: Colors.indigo,
                                        ),
                                        hintText: 'jois',
                                      ),
                                    ),
                                    size_box(),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      key: ValueKey('email'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Incorrect';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        emailController = value!;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.email,
                                          color: Colors.indigo,
                                        ),
                                        hintText: 'jois@gmail.com',
                                      ),
                                    ),
                                    size_box(),
                                    Text(
                                      'Country',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.school,
                                          color: Colors.indigo,
                                        ),
                                        hintText: 'India',
                                      ),
                                    ),
                                    size_box(),
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      key: ValueKey('password'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Incorrect';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        passwordController = value!;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.indigo,
                                        ),
                                        hintText: 'Passowrd',
                                      ),
                                    ),
                                    size_box(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('I agree with'),
                                        custom_button(
                                          pbottom: 0,
                                          pleft: 0,
                                          ptop: 0,
                                          text: ' term & condition',
                                          colour: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          onTap: index_reverse,
                                        ),
                                      ],
                                    ),
                                    size_box(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Already have an Account ?'),
                                        custom_button(
                                          pbottom: 0,
                                          pleft: 0,
                                          ptop: 0,
                                          text: ' Sign In!',
                                          colour: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          onTap: index_reverse,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                ),
                // Login / Register ----------------------------

                size_box(),

                Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: toggleIndex
                        ? Center(
                            child:
                                //  ElevatedButton(child: Text('login'),onPressed: (){},)
                                custom_button(
                              colour: Colors.white70,
                              pbottom: 0,
                              pleft: 0,
                              ptop: 0,
                              fontWeight: FontWeight.bold,
                              text: 'LOGIN',
                              onTap: startauthentication,
                            ),
                          )
                        : Center(
                            child: custom_button(
                              colour: Colors.white70,
                              pbottom: 0,
                              pleft: 0,
                              ptop: 0,
                              fontWeight: FontWeight.bold,
                              text: 'Resgister',
                              onTap: startauthentication,
                            ),
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class custom_button extends StatelessWidget {
  final Function onTap;
  custom_button({
    Key? key,
    required this.fontWeight,
    required this.colour,
    required this.text,
    required this.ptop,
    required this.pbottom,
    required this.pleft,
    required this.onTap,
  }) : super(key: key);
  String text;
  Color colour;
  double pleft;
  double ptop;
  double pbottom;
  FontWeight fontWeight;

  //fontSize _fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: pleft, top: ptop, bottom: pbottom),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Text(
          text,
          style: TextStyle(color: colour, fontWeight: fontWeight, fontSize: 20),
        ),
      ),
    );
  }
}

class size_box extends StatelessWidget {
  const size_box({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
    );
  }
}
