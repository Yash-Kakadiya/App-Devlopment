import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('CRUD', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.red
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(_nameController, 'Name'),
            _buildTextField(_ageController, 'Age'),
            _buildTextField(_cityController, 'City'),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _submitForm(),
              child: const Text('Add', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  void _submitForm() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'age': _ageController.text,
      'city': _cityController.text,
    });
  }
}
