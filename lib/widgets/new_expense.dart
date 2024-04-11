import "package:expense_app/models/expense.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onNewExpense ,super.key});
  final void Function(Expense) onNewExpense;

  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // String? _enteredTitle;
  
  // void _saveTitleInput(String inputValue) {
  //    _enteredTitle = inputValue;
  // }
  // The value which stored will be object
  final _titleController = TextEditingController();
  final _amountsController = TextEditingController();
  final formatter = DateFormat.yMEd();
  DateTime? _selectedDate ;
  Category? _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // Return future type : which is an object that wraps value from 'future', you dont have it yet but you will have
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: now
    );
    // This Line will wait for pickedDate to be complete
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountsController.text); // tryParse only parse number in text format
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      // Show error message
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text('Please make sure a  valid title, amount, date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              }, 
              child: const Text("Ok")
            )
          ],
        )
      );
      return;
    } 
    widget.onNewExpense(
      Expense(
        title: _titleController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory!
      )
    );
  }

  @override
  void dispose() {
    // This function make sure if certain condition met you will remove the controller from memory
    _titleController.dispose();
    super.dispose();
  }
  void amountDispose() {
    _amountsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16, 48, 16, 16
      ),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),),
          const SizedBox(height: 6,),
          Row(
            children: [
             Expanded(
              child: TextField(
                controller: _amountsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '\$',
                  label: Text("Amount"),
                ),
              ),
             ),
             const SizedBox(width: 16,),
             Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null ? 
                    "No Date Selected" : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker, 
                    icon: const Icon(Icons.calendar_month)
                  ),
                ],
              ),
             )
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              DropdownButton(
                // List of all values that make enum
                value: _selectedCategory,
                items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toUpperCase()
                      ),
                    ),
                  ).toList(), 
                onChanged: (value) {
                  if(_selectedCategory == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData, 
                child: const Text("Save Expense"),
              )
            ],
          ),
          const SizedBox(height: 6,),
        ],
      ),
    );
  }
}