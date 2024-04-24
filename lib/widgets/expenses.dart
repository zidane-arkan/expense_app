import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expense_container/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    // DO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
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

  void _addNewExpense(Expense newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = expenses.indexOf(expense);
    // Remove swiped expense
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  void _openAddExpense() {
    // When you in class that extends State, flutter automatically adds a context property
    showModalBottomSheet(
      isScrollControlled: true,
      // Context : metadata collection managed by flutter, so in here holds information about widget ex: expenses
      // and The location in the tree where this widget builds.
      context: context,
      // If you see builder means must provide a function as a value
      builder: (ctx) => NewExpense(
        onNewExpense: _addNewExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (expenses.isNotEmpty) {
      mainContent =
          ExpensesList(onRemoveExpense: _removeExpense, expenses: expenses);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker App"),
        // backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add_rounded),
            color: Colors.white,
          )
        ],
      ),
      body: widthScreen < 600
          ? Column(
              children: [
                Chart(expenses: expenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          // Row also has width.infinity = get as much width it can get
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: expenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
