import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingpctOftoral;

  Chartbar(this.label, this.spendingamount, this.spendingpctOftoral);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.30,
            child: FittedBox(
              child: Text('\₹ ${spendingamount.toStringAsFixed(0)}' , style: TextStyle(fontSize:2),),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
          ),
          Container(
            height: constraints.maxHeight * 0.30,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromARGB(0, 0, 0, 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingpctOftoral,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
          ),
          Container(height: constraints.maxHeight * 0.10, child: FittedBox(child: Text(label),)
          ),

        ],
      );
    });
  }
}
