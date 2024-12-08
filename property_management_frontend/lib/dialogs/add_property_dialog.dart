import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddPropertyDialog extends StatefulWidget {
  final Function onSave;
  final dynamic? property;

  AddPropertyDialog({required this.onSave, this.property});

  @override
  _AddPropertyDialogState createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  String _status = 'active'; // Default value is "active"

  @override
  void initState() {
    super.initState();
    if (widget.property != null) {
      _nameController.text = widget.property?['name'] ?? '';
      _addressController.text = widget.property?['address'] ?? '';
      _priceController.text = widget.property?['price']?.toString() ?? '';
      _status = widget.property?['status'] ?? 'active'; // Set the status if editing a property
    }
  }

  Future<void> save() async {
    try {
      if (widget.property == null) {
        // Handle add logic
        await ApiService.addProperty({
          "name": _nameController.text,
          "address": _addressController.text,
          "price": double.parse(_priceController.text),
          "status": _status, // Include the status when adding a property
        });
      } else {
        // Handle edit logic
        await ApiService.updateProperty(
          widget.property!['id'], // Pass the ID here
          {
            "name": _nameController.text,
            "address": _addressController.text,
            "price": double.parse(_priceController.text),
            "status": _status, // Update the status when editing
          },
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Operation successful")),
      );
      widget.onSave();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Operation failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.property == null ? "Add Property" : "Edit Property"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Property Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            // Add Radio buttons for the status field
            Row(
              children: [
                Text('Status:'),
                Radio<String>(
                  value: 'active',
                  groupValue: _status,
                  onChanged: (String? value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                Text('Active'),
                Radio<String>(
                  value: 'inactive',
                  groupValue: _status,
                  onChanged: (String? value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                Text('Inactive'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: save,
          child: Text("Save"),
        ),
      ],
    );
  }
}
