import "package:flutter/material.dart";
import 'package:intl/intl.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  
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
      padding: const EdgeInsets.all(20),
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () { 
                  print(_amountsController.text);
                }, 
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