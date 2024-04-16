import "package:expense_app/models/expense.dart";
import "package:flutter/material.dart";

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense,{super.key});
  
  final Expense expense;

  @override
  Widget build(BuildContext context){
    return Card(
      child: Padding(
        padding : const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title, 
              style: Theme.of(context).textTheme.titleLarge!,
            ),
            const SizedBox(height: 5,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$ ${(expense.amount).toStringAsFixed(2)}'),
                const SizedBox(width: 5,),
                const Spacer(),
                Row(
                  children: [
                    Icon(expense.icons),
                    const SizedBox(width: 8,),
                    // Text((expense.category).toString()),
                    Text(expense.formattedDates.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}