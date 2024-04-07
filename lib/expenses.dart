import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    // DO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  
  @override  
  Widget build(BuildContext context){
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "The Chart"
            ),
            Text("Expenses List..."),
          ],  
        ),
      ),
    );
  }
}