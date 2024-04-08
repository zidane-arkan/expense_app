import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_container/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
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

  void _openAddExpense() {
    // When you in class that extends State, flutter automatically adds a context property
    showModalBottomSheet(
      // Context : metadata collection managed by flutter, so in here holds information about widget ex: expenses
      // and The location in the tree where this widget builds.
      context: context,
      // If you see builder means must provide a function as a value
      builder: (ctx)  => const NewExpense(),
    );
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text("Expense Tracker App"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _openAddExpense, 
            icon: const Icon(Icons.add_rounded),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          const Text(
            "The Chart"
          ),
          Expanded(
            child: ExpensesList(expenses: expenses),
          ),
        ],  
      ),
    );
  }
}