import 'package:api_provider/provider/second_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Provider Demo"),
        ),
        body: Container(
          child: Consumer<SecondProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Text('${provider.name}'),
                  MaterialButton(
                    onPressed: () {
                      provider.setValue("Manish");
                    },
                    child: Text("Update"),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
