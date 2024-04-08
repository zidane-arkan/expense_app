import "package:flutter/material.dart";

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context){
    return const Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          TextField(
            autocorrect: true,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          SizedBox(height: 6,)
        ],
      ),
    );
  }
}