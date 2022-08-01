// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        /*  Pantalla 40%  */
        height: size.height * 0.4,

        // color: Colors.indigo,
        decoration: _purpleBackground(),
        child: Stack(
          children: [
            //Burujas Orientacion
            Positioned(child: _Bubble(), top: 120, right: 5),
            Positioned(child: _Bubble(), top: 30, left: 10),
            Positioned(child: _Bubble(), top: 80, left: 100),
            Positioned(child: _Bubble(), top: -30, right: -10),
            Positioned(child: _Bubble(), bottom: -30, left: 260),
            Positioned(child: _Bubble(), bottom: 10, right: 100),
            //Positioned(child: _Bubble(), top: -50, left: -40),
            Positioned(child: _Bubble(), top: 190, left: 30),
          ],
        ));
  }

  BoxDecoration _purpleBackground() => BoxDecoration(
          //Metodo _purpleBackground()
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 25), //centrar
      child: Icon(Icons.person_pin, color: Colors.white, size: 90),
    ));
  }
}

//Burbujas -  Contenidas
class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color.fromRGBO(255, 255, 255, 0.05)));
  }
}
