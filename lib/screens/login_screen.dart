import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldlan_apps/providers/login_form_provider.dart';
import 'package:worldlan_apps/ui/input_decorations.dart';
import 'package:worldlan_apps/widgets/auth_background.dart';
import 'package:worldlan_apps/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 180),
          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          )),
          SizedBox(height: 50),
          Text(
            'Crear una Nueva Cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          //TODO: mantener la referencia al KEY
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //notifica sobre la validacion del Correo
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "Freddy@gmail.com",
                    labelText: "Correo Electronico",
                    perfixIcon: Icons.alternate_email_rounded),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  //parametro Importante de validacion Correo
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : "El Valor Ingresado no es Correcto";
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                obscureText: true, //oculta lo que escribes
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: "******",
                    labelText: "Contraseña",
                    perfixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  //parametro Importante de validacion Password
                  return (value != null &&
                          value.length >=
                              6) //limite de caracteres de contraseña
                      ? null
                      : "El Valor Ingresado no es Correcto";
                },
              ),
              SizedBox(height: 20),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Text(
                      loginForm.isLoading ? "Espere...." : "Ingresar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          //funcion para desactivar boton en espere
                          //Quitar teclado
                          FocusScope.of(context).unfocus();

                          //Todo Login Form onPressed
                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoading = true;
                          await Future.delayed(Duration(seconds: 2));
                          //TODO validar si el login es correcto
                          loginForm.isLoading = false;
                          Navigator.pushReplacementNamed(context, "home");
                        })
            ],
          )),
    );
  }
}
