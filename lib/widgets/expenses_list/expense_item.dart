import 'package:flutter/material.dart';

import 'package:tracker_app/models/expense.dart';

//show expenses with card on main page

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
            style: Theme.of(context).textTheme.titleLarge,//if u add something use copywith(),
            
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}',
                //12.3455=>12.34 
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      );
  }
}