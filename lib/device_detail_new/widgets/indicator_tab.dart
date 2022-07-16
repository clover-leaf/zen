import 'package:flutter/material.dart';

class IndicatorTab extends StatelessWidget {
  const IndicatorTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Indicator',
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
