import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormWidgets extends StatefulWidget {
  const FormWidgets({super.key});

  @override
  State<FormWidgets> createState() => _FormWidgetsState();
}

class _FormWidgetsState extends State<FormWidgets> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String title = "";
  String description = "";
  DateTime date = DateTime.now();
  double maxValue = 0;
  bool? isBrushed = false;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      decoration: const InputDecoration(
        labelText: "Title",
        hintText: "Enter a title",
        filled: true,
      ),
      onChanged: (value) {
        setState(() {
          title = value;
        });
      },
    );
    var textFormField2 = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Description",
        hintText: "Enter a description",
        filled: true,
      ),
      maxLines: 5,
      onChanged: (value) {
        description = value;
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form widgets"),
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
                      _FormDatePicker(
                          date: date,
                          onChanged: (date) {
                            setState(() {
                              this.date = date;
                            });
                          }),
                      _EstimatedValuePicker(
                          maxValue: maxValue,
                          onChanged: (value) {
                            setState(() {
                              maxValue = value;
                            });
                          }),
                      Row(
                        children: [
                          Checkbox(
                            value: isBrushed,
                            onChanged: (value) {
                              setState(() {
                                isBrushed = value;
                              });
                            },
                          ),
                          const Text(
                            "Brushed Teeth",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Enable feature"),
                          Switch(
                            value: isEnabled,
                            onChanged: (value){
                              setState(() {
                                isEnabled = value;
                              });
                            },

                          )
                          
                        ],
                      )
                    ].expand((widget) => [widget, const SizedBox(height: 20)]),
                  ],
                ))));
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({required this.date, required this.onChanged});

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(widget.date);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Date", style: TextStyle(fontWeight: FontWeight.w500)),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        TextButton(
          child: const Text("Edit"),
          onPressed: () async {
            var newDate = await showDatePicker(
                context: context,
                initialDate: widget.date,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));

            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}

class _EstimatedValuePicker extends StatefulWidget {
  final double maxValue;
  final ValueChanged<double> onChanged;
  const _EstimatedValuePicker(
      {required this.maxValue, required this.onChanged});

  @override
  State<_EstimatedValuePicker> createState() => __EstimatedValuePickerState();
}

class __EstimatedValuePickerState extends State<_EstimatedValuePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...[
          const Text("Estimated value",
              style: TextStyle(fontWeight: FontWeight.w500)),
          Text(NumberFormat.currency(
                                      symbol: "\$", decimalDigits: 0)
                                  .format(widget.maxValue),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: widget.maxValue,
            onChanged: widget.onChanged,
            min: 0,
            max: 500,
            divisions: 500,
          )
        ].expand((widget) => [widget, const SizedBox(height: 5)])
      ],
    );
  }
}
