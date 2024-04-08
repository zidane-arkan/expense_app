import "package:expense_app/models/expense.dart";
import "package:expense_app/widgets/expense_container/expenses_item.dart";
import "package:flutter/material.dart";

class ExpensesList extends StatelessWidget{
  const ExpensesList({required this.expenses ,super.key});

  final List<Expense> expenses;


  @override
  Widget build(BuildContext context) {
    // Use ListView.builder for lists you dont know how long it will be
    return ListView.builder(
      itemCount: expenses.length, 
      itemBuilder: (ctx, index){
        return ExpensesItem(expenses[index]);
      },);
  }
}