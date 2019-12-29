import 'package:flutter/material.dart';

class NoTx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: <Widget>[
            Text(
              'No transactions added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                height: constraint.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                )),
          ],
        );
      }
    );
  }
}
