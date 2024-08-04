import 'package:flutter/material.dart';

import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/widgets/expenses_list/expense_item.dart';


class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,
  required this.expenses,
  required this.onRemoveExpense
  });


final List<Expense> expenses;
final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
     return ListView.builder(//only necessary expense shows on page
      itemCount: expenses.length,
      
      //give scrolling  with dismiss for remove expense on page
      //if there is one return work use arrow function
     itemBuilder: (ctx,index)=>Dismissible(
      key: ValueKey(expenses[index]),
      background: Container(
       decoration: BoxDecoration(
            color: const Color.fromARGB(100, 164, 164, 164),
            borderRadius: BorderRadius.circular(10), 
          ),

      margin: EdgeInsets.symmetric(horizontal:Theme.of(context).cardTheme.margin!.horizontal),
      ),
      //direction for remove expense to where?
     onDismissed:(direction){
      onRemoveExpense(expenses[index]);
     } ,
     child:ExpenseItem(expenses[index]),
       ),
     );
  }
}