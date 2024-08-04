import 'dart:io';

import 'package:flutter/cupertino.dart';//for ios view
import 'package:flutter/material.dart';

import 'package:tracker_app/models/expense.dart';

//to add new expense

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,
  required this.ondAddExpense});

final void Function (Expense expense) ondAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  
  
  //keep string value by texteditingcpntroller 
  final _titleController = TextEditingController();
  final _amountController=TextEditingController();

 DateTime? _selectedDate;
 Category _selectedCategory=Category.leisure;

//async and await say that the selected date is then chosen by the user
  void _presentDatePicker() async {
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate=await showDatePicker(
   //showDatePicker widget's variables
      context: context,
      initialDate: now,
       firstDate: firstDate,
        lastDate: now,
        );
        setState(() {
          _selectedDate=pickedDate;
        });
      //this code works when user picks the date
        
  }

void _showDialog(){
  if(Platform.isIOS){
showCupertinoDialog(
      context: context, builder: (ctx)=>CupertinoAlertDialog(
        title: const Text('Invalid inputconst '),
      content: const Text('Please make sure a valid title,amount,date and category was entered.'),
      actions: [
        TextButton(onPressed: ()
        {Navigator.pop(ctx);},
         child: const Text('OK.'),
         ),
      ],
      ));
  }
  
      else{
         showDialog(context: context, 
    builder: (ctx)=>AlertDialog(
      title: const Text('Invalid inputconst '),
      content: const Text('Please make sure a valid title,amount,date and category was entered.'),
      actions: [
        TextButton(onPressed: ()
        {Navigator.pop(ctx);},
         child: const Text('OK.'),
         ),
      ],
    ),
    );
      }
   
}

// save ur new expense
void _submitExpenseData(){
  final enteredAmount=double.tryParse(_amountController.text);
  final amountIsInvalid=enteredAmount==null||enteredAmount<=0;//if ur string value doesnt turn double for any reasons,It returns null and value has to be >0
  //control for user's input 
  if(_titleController.text.trim().isEmpty||
  amountIsInvalid||
  _selectedDate==null){
    _showDialog();
    return;
  }
  widget.ondAddExpense(
    Expense(
    title: _titleController.text,
   amount: enteredAmount, 
    date: _selectedDate!,//says ıt cant be null
    category:_selectedCategory ,
    ),
    );
    Navigator.pop(context);
}

  @override
//delete 'texteditingcontroller' for device storage 
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
      
    final width=constraints.maxWidth;
     //example- print(constraints.minHeight);
     //tells us what the minimum height for this widget can be(88.line widget)
      
      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(//scrollable screen for responsive design
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16,48,16,keyboardSpace+16),
          child: Column(
            children: [
              //input title
              //if else for responsive screen (there is no {} for if and ()for else this is special for list type )
              if(width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Expanded(
                  child: TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    ),
                                ),
                ),
              const SizedBox(width: 24 ,),
               Expanded(
                 child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText:'\$ ',
                    label: Text('Amount'),
                    ),
                           ),
               ),
              ],
              )
              else
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  ),
              ),
             if(width>=600)
             Row(children: [
               DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map(
                  (category)=> DropdownMenuItem(
                    //değer enum öğelerinden biri
                    value: category,
                    child: Text(category.name.toUpperCase(),
                    ),
                    ),
                  ).toList(),
                   onChanged: (value){
                      if(value==null){
                        return;
                      }
                      setState(() {
                        _selectedCategory=value;
                      });
                   },
                   ),
                   const SizedBox(width: 24,),
                   Expanded(
                child: Row(
                  //yatay sona koy
                  mainAxisAlignment: MainAxisAlignment.end,
                  //dikey ortalama
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //it cant be null
                   Text(_selectedDate==null
                    ?'No date selected'
                    :formatter.format(_selectedDate!),
                    ),
                    IconButton(onPressed: _presentDatePicker,
                    icon: const Icon
                    (Icons.calendar_month),
                    ),
                  ],
                ),
              )

             ],)
             else 
             Row(
              children: [
              //input amount
               Expanded(
                 child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText:'\$ ',
                    label: Text('Amount'),
                    ),
                           ),
               ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  //yatay sona koy
                  mainAxisAlignment: MainAxisAlignment.end,
                  //dikey ortalama
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //it cant be null
                   Text(_selectedDate==null
                    ?'No date selected'
                    :formatter.format(_selectedDate!),
                    ),
                    IconButton(onPressed: _presentDatePicker,
                    icon: const Icon
                    (Icons.calendar_month),
                    ),
                  ],
                ),
              )
        
             ],),
              
              const SizedBox(height: 16,),
              if(width>=600)
              Row(children: [
                 const Spacer(
        
                   ),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    //save user's choice
                      onPressed:_submitExpenseData,
                      child: const Text('Save Expense'),
                      ),
              ],)
              else
               Row(
                children: [
                  //for user's category choice
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map(
                  (category)=> DropdownMenuItem(
                    //değer enum öğelerinden biri
                    value: category,
                    child: Text(category.name.toUpperCase(),
                    ),
                    ),
                  ).toList(),
                   onChanged: (value){
                      if(value==null){
                        return;
                      }
                      setState(() {
                        _selectedCategory=value;
                      });
                   },
                   ),
                   const Spacer(
        
                   ),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    //save user's choice
                      onPressed:_submitExpenseData,
                      child: const Text('Save Expense'),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    }); 
  }
}
