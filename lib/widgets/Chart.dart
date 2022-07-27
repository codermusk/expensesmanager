import 'package:expensemanager/models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTranscation;

  Chart(this.recentTranscation);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (int i = 0; i < recentTranscation.length; i++) {
        if (recentTranscation[i].date.day == weekday.day &&
            recentTranscation[i].date.month == weekday.month &&
            recentTranscation[i].date.year == weekday.year) {
          totalsum += recentTranscation[i].price;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'price': totalsum
      };
    }).reversed.toList();
  }

  double get totalspending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['price'];
    });  
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((e) {
            return Flexible(
                fit: FlexFit.tight,
                child: Chartbar(
                    e['day'],
                    e['price'],
                    totalspending == 0.0
                        ? 0.0
                        : (e['price'] as double) / totalspending));
          }).toList(),
        ),
      ),
    );
  }
}
