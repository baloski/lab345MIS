import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import '../Widgets/adaptive_flat_button.dart';
import '../Models/list_item.dart';

class NewElement extends StatefulWidget {
  final Function addItem;

  NewElement(this.addItem);
  @override
  State<StatefulWidget> createState() => _NewElementState();
}

class _NewElementState extends State<NewElement> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _submitData() {
    if (_valueController.text.isEmpty) {
      return;
    }
    final title = _titleController.text;
    final value = _valueController.text;
    final latitude = _latitudeController.text;
    final longitude = _longitudeController.text;

    if (title.isEmpty || value.isEmpty || longitude.isEmpty || latitude.isEmpty) {
      return;
    }

    final newItem = ListItem(id: nanoid(5), subject: title,
      date: DateTime.parse(value),
      latitude: double.parse(latitude) ,
      longitude: double.parse(longitude),);
    widget.addItem(newItem);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Subject added"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: "Subject",),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(labelText: "Date"),
            keyboardType: TextInputType.datetime,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _latitudeController,
            decoration: InputDecoration(labelText: "Latitude"),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _longitudeController,
            decoration: InputDecoration(labelText: "Longitude"),
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          AdaptiveFlatButton("Add", _submitData)
        ],
      ),
    );
  }
}