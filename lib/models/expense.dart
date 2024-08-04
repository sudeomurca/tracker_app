import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';//for every expense object has dinamic id 

final formatter=DateFormat.yMd();

const uuid=Uuid();//for create id 

//to create custom variables,custom type(enum)
enum Category
 {food,travel,leisure,work}

const categoryIcons={
  Category.food: Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
};

class Expense{
  //ctor necessary to create object
  Expense({
    required this.title,
    required this.amount, 
   required this.date,
   required this.category,
   }) : id=uuid.v4() ;//create unique id
   
   //expense's variables
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

//aeshetic date view
  String get formattedDate{
    return formatter.format(date);
  }
}
// create buckets for each categories

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

//forcategory is extra name for ctor (ex. edgeinsets.symetric "symetric" )
// a list filter according to category, if it's equal add to list, otherwise doen't take

ExpenseBucket.forCategory(List<Expense> allExpenses,this.category) 
: expenses=allExpenses
.where((expense) =>expense.category==category)
.toList();



  final Category category;
  final List <Expense> expenses;
//add amounts to 'sum',return sum 
  double get totalExpenses{
    double sum=0;
   
   for (final expense in expenses){
    sum += expense.amount;
   }
    
    return sum;
  }
}