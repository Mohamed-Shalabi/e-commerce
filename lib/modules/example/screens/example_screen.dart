import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // final themesViewModel = context.read<AppThemes>();
              // themesViewModel.isLight = !themesViewModel.isLight;


            },
            icon: const Icon(Icons.brightness_4_outlined),
          )
        ],
      ),
    );
  }
}
