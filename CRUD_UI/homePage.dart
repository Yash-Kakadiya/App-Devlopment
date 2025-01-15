import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_labs/crud/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> userList = [];

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();

  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: isGrid ? _buildGridView() : _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      leading: const Icon(Icons.person, color: Colors.white),
      title: const Text('CRUD', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(isGrid ? Icons.grid_3x3_outlined : Icons.list),
          color: Colors.white,
          onPressed: () => setState(() => isGrid = !isGrid),
        ),
      ],
    );
  }

  /// Builds ListView
  Widget _buildListView() {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (_, index) => _buildUserCard(index),
    );
  }

  /// Builds GridView
  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: userList.length,
      itemBuilder: (_, index) => _buildUserCard(index),
    );
  }

  /// Builds User Card
  Widget _buildUserCard(int index) {
    final user = userList[index];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(index),
            _buildUserInfo(user['age'], Colors.orange),
            _buildUserInfo(user['city'], Colors.blue),
          ],
        ),
      ),
    );
  }

  /// Builds Card Header with name and action buttons
  Widget _buildCardHeader(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            userList[index]['name'],
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => _editDetails(index)),
        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _confirmDelete(index)),
      ],
    );
  }

  /// Builds User Info Row
  Widget _buildUserInfo(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  /// Navigates to Form Page
  Future<void> _navigateToForm() async {
    final newUser = await Navigator.push(context, MaterialPageRoute(builder: (_) => FormPage()));
    if (newUser != null) {
      userList.add(newUser);
      setState(() {});
    }
  }

  /// Opens Edit Dialog
  Future<void> _editDetails(int index) {
    final user = userList[index];

    _nameController.text = user['name'];
    _ageController.text = user['age'];
    _cityController.text = user['city'];

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Details'),
        content: _buildEditForm(),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => _saveEdit(index), child: const Text('Save')),
        ],
      ),
    );
  }

  /// Builds Edit Form Fields
  Widget _buildEditForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTextField(_nameController, 'Name'),
        const SizedBox(height: 10),
        _buildTextField(_ageController, 'Age'),
        const SizedBox(height: 10),
        _buildTextField(_cityController, 'City'),
      ],
    );
  }

  /// Builds Text Field
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Saves Edited User Data
  void _saveEdit(int index) {
    userList[index] = {
      'name': _nameController.text,
      'age': _ageController.text,
      'city': _cityController.text,
    };
    Navigator.pop(context);
    setState(() {});
  }

  /// Confirm Delete Dialog
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to delete?'),
        actions: [
          TextButton(onPressed: () => _deleteUser(index), child: const Text('YES')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('NO')),
        ],
      ),
    );
  }

  /// Deletes User
  void _deleteUser(int index) {
    userList.removeAt(index);
    Navigator.pop(context);
    setState(() {});
  }
}