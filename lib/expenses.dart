import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_container/expenses_list.dart';
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
  
  List<Expense> expenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override  
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "The Chart"
            ),
            Expanded(
              child: ExpensesList(expenses: expenses),
            ),
          ],  
        ),
      ),
    );
  }
}