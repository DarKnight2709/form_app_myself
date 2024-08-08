import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:english_words/english_words.dart' as english_words;

class Validation extends StatefulWidget {
  const Validation({super.key});

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String adjective = "";
  String noun = "";
  bool? agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      decoration: const InputDecoration(
          filled: true,
          labelText: "Enter an adjective",
          hintText: "e.g. quick, interesting, beautiful"),
      onChanged: (value) {
        adjective = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter an adjective";
        }
        if (english_words.adjectives.contains(value)) return null;
        return "Not a valid adjective";
      },
    );
    var textFormField2 = TextFormField(
      decoration: const InputDecoration(
          filled: true,
          labelText: "Enter an noun",
          hintText: "i.e. person, place or thing"),
      onChanged: (value) {
        noun = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter an noun";
        }
        if (english_words.nouns.contains(value)) return null;
        return "Not a valid noun";
      },
    );
    var formField = FormField(
                    initialValue: agreedToTerms,
                    validator: (value) {
                      if (value == false) {
                        return "You must agree to the terms of service.";
                      }
                      return null;
                    },
                    builder: (formFieldState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: agreedToTerms,
                                onChanged: (value) {
                                  formFieldState.didChange(value);

                                  setState(() {
                                    agreedToTerms = value;
                                  });
                                },
                              ),
                              const Text("I agree to the terms of service.",
                                  style: TextStyle(fontWeight: FontWeight.w600))
                            ],
                          ),
                          if (!formFieldState.isValid)
                            // if null then ""
                            Text(formFieldState.errorText ?? "",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12,
                                ))
                        ],
                      );
                    },
                  );
    return Scaffold(
        appBar: AppBar(
          title: const Text('📖 Story Generator'),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                if (key.currentState!.validate()) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Your story"),
                          content: Text("The $adjective developer saw a $noun"),
                          actions: [
                            TextButton(
                              child: const Text("Done"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
              },
            )
          ],
        ),
        body: Form(
          key: key,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...[
                  textFormField,
                  textFormField2,
                  formField
                ].expand((widget) => [widget, const SizedBox(height: 20)])
              ],
            ),
          ),
        ));
  }
}
