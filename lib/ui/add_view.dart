import 'package:crash_course/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ["bitcoin", "dogecoin", "litecoin"];
  String dropdownValue = "bitcoin";
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownValue,
            onChanged: (String? value) {
              /*
                Why use 'setState' below?
                -------------------------
                Calling setState notifies the framework that the internal state of
                this object has changed in a way that might impact the user interface in this subtree,
                which causes the framework to schedule a build for this State object.
                If you just change the state directly without calling setState,
                the framework might not schedule a build and the user interface for
                this subtree might not be updated to reflect the new state.
               */
              setState(() {
                dropdownValue = value!;
              });
            },
            items: coins.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Coin Amount",
                ),
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              onPressed: () async {
                await addCoin(dropdownValue, amountController.text);

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          )
        ],
      ),
    );
  }
}
