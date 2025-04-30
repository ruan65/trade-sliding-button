import 'package:flutter/material.dart';
import '../widgets/trade_sliding_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TradeSlidingButton(
              text: 'Сдвиньте, чтобы купить',
              onPressed: () {},
            ),
            TradeSlidingButton(
              text: 'Сдвиньте, чтобы купить',
              onPressed: () {},
            ),
            TradeSlidingButton(
              text: 'Сдвиньте, чтобы купить',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
