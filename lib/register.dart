import 'package:coffemate/auth.dart';
import 'package:coffemate/constants.dart';
import 'package:coffemate/home.dart';
import 'package:flutter/cupertino.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool topico = false;

  Auth auth = Auth();
  String name = "";
  String email = "";
  String pass = "";
  bool seePass = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.all(4.0),
        middle: Image.asset("lib/assets/mercedes_logo.png"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.person_add,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => const Register(),
              ),
            );
          },
        ),
      ),
      // resizeToAvoidBottomInset: true,
      child: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: topico ? 0 : 90),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80.0, vertical: 32.0),
                    child: const Text(
                      "Registro",
                      style: tsH3Blue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: const Text(
                      "Name",
                      style: tsH1Black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CupertinoTextField(
                      padding: const EdgeInsets.all(12.0),
                      onChanged: (value) => name = value,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.number,
                      placeholder: "Enter your name",
                      prefix: Container(
                          height: 20.0,
                          margin: const EdgeInsets.only(left: 12.0),
                          child: const Icon(CupertinoIcons.mail)),
                      // placeholder: "Usuario",
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: greyLightColor),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: const Text(
                      "Email",
                      style: tsH1Black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CupertinoTextField(
                      padding: const EdgeInsets.all(12.0),
                      onChanged: (value) => email = value,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.number,
                      placeholder: "Enter your email",

                      prefix: Container(
                          height: 20.0,
                          margin: const EdgeInsets.only(left: 12.0),
                          child: const Icon(CupertinoIcons.mail)),
                      // placeholder: "Usuario",
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: greyLightColor),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: const Text(
                      "Password",
                      style: tsH1Black,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CupertinoTextField(
                      padding: const EdgeInsets.all(12.0),
                      onChanged: (value) => pass = value,
                      cursorColor: primaryColor,
                      obscureText: !seePass,
                      keyboardType: TextInputType.visiblePassword,
                      placeholder: "Enter your password",
                      prefix: Container(
                          height: 20.0,
                          margin: const EdgeInsets.only(left: 12.0),
                          child: const Icon(CupertinoIcons.lock)),
                      suffix: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          seePass
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill,
                          size: 16.0,
                        ),
                        onPressed: () {
                          setState(() {
                            seePass = !seePass;
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: greyLightColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: secondaryColor,
                    // padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                    child: const Text("Login"),
                    onPressed: () async {
                      String op = await auth.signUpUser(
                          email: email, password: pass, name: name);
                      op == "success"
                          ? Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const Home(),
                              ),
                            )
                          : showCupertinoSnackBar(
                              context: context, message: op);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
