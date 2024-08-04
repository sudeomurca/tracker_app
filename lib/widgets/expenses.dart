import 'package:flutter/material.dart';

import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/widgets/chart/chart.dart';
import 'package:tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:tracker_app/widgets/new_expense.dart';

//Main Page

class Expenses extends StatefulWidget{
  const Expenses({super.key});

   @override
   State <Expenses> createState() {
   return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
final List <Expense> _registeredExpenses=[
  Expense(
    title: 'Flutter course',
   amount: 19.99,
    date: DateTime.now(),
    category: Category.work,
    ),

     Expense(title: 'Cinema',
   amount: 15.69,
    date: DateTime.now(),
    category: Category.leisure,
    ),
];
//this page for create new expense
  void _openAddExpenseOverlay() {
    //context widget konumuyla alakalı
     showModalBottomSheet(
      useSafeArea: true,//for responsive screen
      isScrollControlled: true,
      context: context, builder: (ctx)=>
      NewExpense(ondAddExpense: _addExpense),//newexpenses's function=_addExpense function
     );
  }

//function for add new expense
  void _addExpense(Expense expense){
setState(() {
  _registeredExpenses.add(expense);
});
  }
//function for delete expense
  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      //delete works
      _registeredExpenses.remove(expense);
    });
    
//only show the snackbar of the newly deleted expense
    ScaffoldMessenger.of(context).clearSnackBars();
    // alert for deleted expense,add take back action "undo" 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration:const  Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label:'Undo' ,
          onPressed:(){
            setState(() {
              //deleted expense re-add it's index 
              _registeredExpenses.insert(expenseIndex,expense);
            });
          } ,
          ),
        ),
      );
  }

  @override
  //if there is no expense show the text,else u can remove what expense u want
  Widget build(BuildContext context) {
final width= MediaQuery.of(context).size.width;//ur device's width


Widget mainContent= const Center(
  child: Text('No expenses found.Start adding some!'),
);
if (_registeredExpenses.isNotEmpty){
  mainContent= ExpensesList(expenses:  _registeredExpenses,
            onRemoveExpense:_removeExpense,
  );
}

     return  Scaffold(
      appBar: AppBar(
       
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay ,
           icon: const Icon(Icons.add),)
        ],
      ),
       body: width<600 ? Column(//if width <600 use vertical
         children:  [
           Chart(expenses: _registeredExpenses),
          
           Expanded (
            child:mainContent ,
            ),
        ],
      ): Row(children: [
        Expanded(
          //The reason for wrapping with 'expanded' is that chart is 'double infinity' and it will give an error when written into row
          child: Chart(expenses: _registeredExpenses)),
          
           Expanded (
            child:mainContent ,
            ),
      ],)
     );
  }
}